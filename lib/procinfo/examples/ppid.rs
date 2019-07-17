// Copyright 2019 Facebook, Inc.
//
// This software may be used and distributed according to the terms of the
// GNU General Public License version 2 or any later version.

fn main() {
    let mut ppid = procinfo::parent_pid(0);
    while ppid != 0 {
        let name = procinfo::exe_name(ppid);
        println!("Parent PID: {:8}  Name: {}", ppid, name);
        ppid = procinfo::parent_pid(ppid);
    }
}
