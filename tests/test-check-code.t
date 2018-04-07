#require test-repo

  $ . "$TESTDIR/helpers-testrepo.sh"
  $ check_code="$TESTDIR"/../contrib/check-code.py
  $ cd "$TESTDIR"/..

New errors are not allowed. Warnings are strongly discouraged.
(The writing "no-che?k-code" is for not skipping this file when checking.)

  $ testrepohg files -I . \
  > -X contrib/python-zstandard \
  > -X hgext/fsmonitor/pywatchman \
  > -X lib/cdatapack \
  > -X lib/third-party \
  > -X mercurial/thirdparty \
  > -X fb-hgext \
  > -X fb/packaging \
  > | sed 's-\\-/-g' | "$check_code" --warnings --per-file=0 - || false
  fb/tests/sqldirstate_benchmark.py:100:
   >             hg.next()
   don't use .next(), use next(...)
  fb/tests/test-hg-rsh.t:2:
   >   $ HGRSH=$TESTDIR/../staticfiles/bin/hg-rsh
   don't use explicit paths for tools
  fb/tests/test-hg-rsh.t:35:
   >   > %include /bin/../etc/mercurial/repo-specific/common.rc
   don't use explicit paths for tools
  Skipping hgext/extlib/cfastmanifest.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/bsearch.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/bsearch.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/bsearch_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/checksum.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/checksum.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/checksum_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/internal_result.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/node.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/node.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/node_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/path_buffer.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/result.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tests.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tests.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_arena.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_arena.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_convert.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_convert_rt.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_convert_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_copy.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_copy_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_diff.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_diff_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_disk.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_disk_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_dump.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_iterate_rt.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_iterator.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_iterator.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_iterator_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_path.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_path.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cfastmanifest/tree_test.c it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/datapackstore.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/datapackstore.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/datastore.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/deltachain.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/deltachain.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/key.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/match.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/py-cdatapack.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/py-cstore.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/py-datapackstore.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/py-structs.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/py-treemanifest.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/pythondatastore.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/pythondatastore.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/pythonkeyiterator.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/pythonutil.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/pythonutil.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/store.h it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/uniondatapackstore.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/cstore/uniondatapackstore.h it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest.h it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest_entry.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest_entry.h it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest_fetcher.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest_fetcher.h it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest_ptr.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/manifest_ptr.h it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/treemanifest.cpp it has no-che?k-code (glob)
  Skipping hgext/extlib/ctreemanifest/treemanifest.h it has no-che?k-code (glob)
  Skipping hgext/hgsql.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/__init__.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/compathacks.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/editor.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/hooks/updatemeta.py it has no-che?k-code (glob)
  hgext/hgsubversion/layouts/__init__.py:1:
   > """Code for dealing with subversion layouts
   don't capitalize docstring title
  Skipping hgext/hgsubversion/layouts/base.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/layouts/custom.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/layouts/standard.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/maps.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/pushmod.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/stupid.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svncommands.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnexternals.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnmeta.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnrepo.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnwrap/__init__.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnwrap/common.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnwrap/subvertpy_wrapper.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/svnwrap/svn_swig_wrapper.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/util.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/verify.py it has no-che?k-code (glob)
  Skipping hgext/hgsubversion/wrappers.py it has no-che?k-code (glob)
  hgext/morestatus.py:48:
   >                 os.getcwd()) for path in unresolvedlist])
   use pycompat.getcwd instead (py3)
  hgext/phabstatus.py:80:
   >             repodir=os.getcwd(), ca_bundle=ca_certs, repo=repo)
   use pycompat.getcwd instead (py3)
  hgext/undo.py:71:
   >     if 'CHGINTERNALMARK' in os.environ:
   use encoding.environ instead (py3)
  hgext/undo.py:89:
   >     if '_undologactive' in os.environ:
   use encoding.environ instead (py3)
  hgext/undo.py:97:
   >             os.environ['_undologactive'] = "active"
   use encoding.environ instead (py3)
  hgext/undo.py:127:
   >                 del os.environ['_undologactive']
   use encoding.environ instead (py3)
  Skipping i18n/polib.py it has no-che?k-code (glob)
  Skipping lib/clib/buffer.c it has no-che?k-code (glob)
  Skipping lib/clib/buffer.h it has no-che?k-code (glob)
  Skipping lib/clib/convert.h it has no-che?k-code (glob)
  Skipping lib/clib/null_test.c it has no-che?k-code (glob)
  Skipping lib/clib/portability/inet.h it has no-che?k-code (glob)
  Skipping lib/clib/portability/mman.h it has no-che?k-code (glob)
  Skipping lib/clib/portability/portability.h it has no-che?k-code (glob)
  Skipping lib/clib/portability/unistd.h it has no-che?k-code (glob)
  Skipping lib/clib/sha1.h it has no-che?k-code (glob)
  Skipping mercurial/httpclient/__init__.py it has no-che?k-code (glob)
  Skipping mercurial/httpclient/_readers.py it has no-che?k-code (glob)
  Skipping mercurial/statprof.py it has no-che?k-code (glob)
  Skipping tests/badserverext.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-custom-layout.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-obsstore-on.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-rebuildmeta.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-sqlite-revmap.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-stupid-pull.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-updatemeta.py it has no-che?k-code (glob)
  Skipping tests/comprehensive/test-hgsubversion-verify-and-startrev.py it has no-che?k-code (glob)
  Skipping tests/conduithttp.py it has no-che?k-code (glob)
  Skipping tests/fixtures/rsvn.py it has no-che?k-code (glob)
  Skipping tests/test-fb-hgext-remotefilelog-bad-configs.t it has no-che?k-code (glob)
  tests/test-hggit-git-submodules.t:61:
   >   $ grep 'submodule "subrepo2"' -A2 .gitmodules > .gitmodules-new
   don't use grep's context flags
  tests/test-hggit-gitignore.t:124:
   >   $ echo 'foo.*$(?<!bar)' >> .hgignore
   don't use $(expr), use `expr`
  tests/test-hggit-renames.t:79:
   >   $ grep 'submodule "gitsubmodule"' -A2 .gitmodules > .gitmodules-new
   don't use grep's context flags
  Skipping tests/test-hgsql-encoding.t it has no-che?k-code (glob)
  Skipping tests/test-hgsql-race-conditions.t it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-externals.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-fetch-branches.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-fetch-command-regexes.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-fetch-command.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-fetch-exec.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-fetch-mappings.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-fetch-symlinks.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-push-command.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-push-dirs.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-push-renames.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-single-dir-clone.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-single-dir-push.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-svn-pre-commit-hooks.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-svnwrap.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-tags.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-template-keywords.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-urls.py it has no-che?k-code (glob)
  Skipping tests/test-hgsubversion-utility-commands.py it has no-che?k-code (glob)
  tests/test-revset.t:2759:
   >   > . +
   warning: ^ must be quoted
  Skipping tests/test_hgsubversion_util.py it has no-che?k-code (glob)
  [1]

@commands in debugcommands.py should be in alphabetical order.

  >>> import re
  >>> commands = []
  >>> with open('mercurial/debugcommands.py', 'rb') as fh:
  ...     for line in fh:
  ...         m = re.match("^@command\('([a-z]+)", line)
  ...         if m:
  ...             commands.append(m.group(1))
  >>> scommands = list(sorted(commands))
  >>> for i, command in enumerate(scommands):
  ...     if command != commands[i]:
  ...         print('commands in debugcommands.py not sorted; first differing '
  ...               'command is %s; expected %s' % (commands[i], command))
  ...         break

Prevent adding new files in the root directory accidentally.

  $ testrepohg files 'glob:*'
  .clang-format
  .editorconfig
  .flake8
  .gitignore
  .hg-vendored-crates
  .hgsigs
  .jshintrc
  .watchmanconfig
  CONTRIBUTING
  CONTRIBUTORS
  COPYING
  Makefile
  README.rst
  TARGETS
  hg
  hgeditor
  hgweb.cgi
  setup.py
  vendorcrates.py
