// Copyright Facebook, Inc. 2018
use crate::python::{
    py_finalize, py_init_threads, py_initialize, py_set_argv, py_set_program_name,
};
use cpython::{exc, NoArgs, ObjectProtocol, PyResult, Python, PythonObject};
use encoding::osstring_to_local_cstring;
use std::env;
use std::ffi::CString;

const HGPYENTRYPOINT_MOD: &str = "edenscm.mercurial.entrypoint";
pub struct HgPython {}

impl HgPython {
    pub fn new() -> HgPython {
        Self::setup_python();
        HgPython {}
    }

    fn setup_python() {
        let args = Self::args_to_local_cstrings();
        let executable_name = args[0].clone();
        py_set_program_name(executable_name);
        py_initialize();
        py_set_argv(args);
        py_init_threads();
    }

    fn args_to_local_cstrings() -> Vec<CString> {
        // Replace args[0] with the absolute current_exe path. This workarounds
        // an issue in libpython sys.path handling.
        //
        // More context: Usually, argv[0] is either:
        // - a relative path to the executable, like "hg", or "./hg". It can be
        //   translated to an absolute path using the PATH environment variable
        //   and the current workdir.
        // - an absolute path to the executable, like "/bin/hg".
        //
        // When running as local build, we expect libpython to add the
        // "executable path" to sys.path. However, libpython seems pretty dumb
        // if argv[0] is a relative path, and it's not in the current workdir
        // (in other words, libpython seems to ignore PATH). Therefore, give
        // it some hint by passing the absolute path resolved by the Rust stdlib.
        Some(env::current_exe().unwrap().into_os_string())
            .into_iter()
            .chain(env::args_os().skip(1))
            .map(|x| osstring_to_local_cstring(&x))
            .collect()
    }

    pub fn run_py(&self, py: Python<'_>) -> PyResult<()> {
        let entry_point_mod = py.import(HGPYENTRYPOINT_MOD)?;
        entry_point_mod.call(py, "run", NoArgs, None)?;
        Ok(())
    }

    pub fn run(&self) -> i32 {
        let gil = Python::acquire_gil();
        let py = gil.python();
        match self.run_py(py) {
            // The code below considers the following exit scenarios:
            // - `PyResult` is `Ok`. This means that the Python code returned
            //    successfully, without calling `sys.exit` or raising an
            //    uncaught exception
            // - `PyResult` is a `PyErr(SystemExit)`. This means that the Python
            //    code called `sys.exit`.
            //    - The expected case is that the `SystemExit` instance contains
            //      a `code` attribute, which is the desired exit code.
            //    - If it does not, we fail hard with code 255.
            // - `PyResult` is a `PyErr(UncaughtException)`. Something went wrong.
            //    Python's behavior in this case is to print a traceback and to
            //    return 1.
            Err(mut err) => {
                if let Ok(system_exit) = err.instance(py).extract::<exc::SystemExit>(py) {
                    match system_exit.as_object().getattr(py, "code") {
                        Ok(code) => code.extract::<i32>(py).unwrap(),
                        Err(_) => 255,
                    }
                } else {
                    // Print a traceback
                    err.print(py);
                    1
                }
            }
            Ok(()) => 0,
        }
    }
}

impl Drop for HgPython {
    fn drop(&mut self) {
        py_finalize();
    }
}
