---
date: 2020-07-08
title: "New git commands: git switch & git restore!"
author: pavlo.golub@cybertec.at
tags: ["git", "checkout", "development"]
description: "git 2.23 introduces new commands: switch and restore. They might help aid migration efforts from SVN" # max. 300 chars.
---

For a long time, I was working with SVN as my default version control system. I liked it a lot for its clear syntax.

When I switched to the git, I was surprised how overloaded the `checkout` sub-command really is:

— You need to switch to another branch? Use `git checkout`. 

— You need to revert modifications made to files? Use `git checkout`. 

In SVN you have separate commands for each of these tasks.

Starting with git 2.23 we have new sub-commands to address this:
* `git switch` to switch between branches
* `git restore` to undo all modifications made

I'm sure this new syntax will be a great help for newcomers from SVN. Consider this new workflow. Extremely clear to me!

```console
pasha@PG480 MINGW64 ~/go/src/github.com/cybertec-postgresql/pg_timetable (master)
$ git switch docker-tests
Switched to branch 'docker-tests'
Your branch is up to date with 'origin/docker-tests'.

pasha@PG480 MINGW64 ~/go/src/github.com/cybertec-postgresql/pg_timetable (docker-tests)
$ rm README.md

pasha@PG480 MINGW64 ~/go/src/github.com/cybertec-postgresql/pg_timetable (docker-tests)
$ git status
On branch docker-tests
Your branch is up to date with 'origin/docker-tests'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    README.md

no changes added to commit (use "git add" and/or "git commit -a")

pasha@PG480 MINGW64 ~/go/src/github.com/cybertec-postgresql/pg_timetable (docker-tests)
$ git restore README.md

pasha@PG480 MINGW64 ~/go/src/github.com/cybertec-postgresql/pg_timetable (docker-tests)
$ git status
On branch docker-tests
Your branch is up to date with 'origin/docker-tests'.
nothing to commit, working tree clean
```
