#chg-compatible
#debugruntest-compatible

  $ eagerepo
  $ . "$TESTDIR/histedit-helpers.sh"

  $ configure mutation-norecord
  $ enable fbhistedit histedit rebase

  $ initrepo ()
  > {
  >     hg init r
  >     cd r
  >     for x in a b c d e f ; do
  >         echo $x > $x
  >         hg add $x
  >         hg ci -m $x
  >     done
  > }

  $ initrepo

log before edit

  $ hg log --graph
  @  commit:      652413bf663e
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     f
  │
  o  commit:      e860deea161a
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     e
  │
  o  commit:      055a42cdd887
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     d
  │
  o  commit:      177f92b77385
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     c
  │
  o  commit:      d2ae7f538514
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     b
  │
  o  commit:      cb9a9f314b8b
     user:        test
     date:        Thu Jan 01 00:00:00 1970 +0000
     summary:     a
  

stop & continue cannot preserve hashes without obsolescence

  $ hg histedit 177f92b77385 --commands - 2>&1 << EOF| fixbundle
  > pick 177f92b77385 c
  > pick 055a42cdd887 d
  > stop e860deea161a e
  > pick 652413bf663e f
  > EOF
  Changes committed as 04d2fab98077. You may amend the changeset now.
  When you are done, run hg histedit --continue to resume

  $ hg histedit --continue

  $ hg log --graph
  @  commit:      794fe033d0a0
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     f
  │
  o  commit:      04d2fab98077
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     e
  │
  o  commit:      055a42cdd887
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     d
  │
  o  commit:      177f92b77385
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     c
  │
  o  commit:      d2ae7f538514
  │  user:        test
  │  date:        Thu Jan 01 00:00:00 1970 +0000
  │  summary:     b
  │
  o  commit:      cb9a9f314b8b
     user:        test
     date:        Thu Jan 01 00:00:00 1970 +0000
     summary:     a
  

stop on a commit

  $ hg histedit 177f92b77385 --commands - 2>&1 << EOF| fixbundle
  > pick 177f92b77385 c
  > pick 055a42cdd887 d
  > stop 04d2fab98077 e
  > pick 794fe033d0a0 f
  > EOF
  Changes committed as d28623a90f2b. You may amend the changeset now.
  When you are done, run hg histedit --continue to resume

  $ hg id -r . -i
  d28623a90f2b
  $ echo added > added
  $ hg add added
  $ hg commit --amend

  $ hg log -v -r '.' --template '{files}\n'
  added e
  $ hg histedit --continue

  $ hg log --graph --template '{node|short} {desc} {files}\n'
  @  099559071076 f f
  │
  o  d51720eb7a13 e added e
  │
  o  055a42cdd887 d d
  │
  o  177f92b77385 c c
  │
  o  d2ae7f538514 b b
  │
  o  cb9a9f314b8b a a
  

check histedit_source

  $ hg log --debug --rev d51720eb7a133e2dabf74a445e509a3900e9c0b5
  commit:      d51720eb7a133e2dabf74a445e509a3900e9c0b5
  phase:       draft
  manifest:    b2ebbc42649134e3236996c0a3b1c6ec526e8f2e
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  files+:      added e
  extra:       amend_source=d28623a90f2b5c38b6c3ca503c86847b34c9bfdf
  extra:       branch=default
  extra:       histedit_source=04d2fab980779f332dec458cc944f28de8b43435
  description:
  e
  
  
fold a commit to check if other non-pick actions are handled correctly

  $ hg histedit 177f92b77385 --commands - 2>&1 << EOF| fixbundle
  > pick 177f92b77385 c
  > fold 055a42cdd887 d
  > stop d51720eb7a13 e
  > pick 099559071076 f
  > EOF
  Changes committed as 08cf87522012. You may amend the changeset now.
  When you are done, run hg histedit --continue to resume

  $ hg histedit --continue

  $ hg log --graph --template '{node|short} {desc} {files}\n'
  @  3c9ba74168ea f f
  │
  o  08cf87522012 e added e
  │
  o  66584b8c84e1 c
  │  ***
  │  d c d
  o  d2ae7f538514 b b
  │
  o  cb9a9f314b8b a a
  
