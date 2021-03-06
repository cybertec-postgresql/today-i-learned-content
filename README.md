<h1 align="center">Today I learned @Cybertec - Content</h1>

<div align="center">
  <strong>Today I learned is a collection of short posts, mostly about weird stuff we found while working.</strong>
</div>

<br />

<p align="center">
  <a href="https://github.com/cybertec-postgresql/today-i-learned">Source Code Repository</a> •
  <a href="https://github.com/cybertec-postgresql/today-i-learned-content">Content Repository</a> •
  <a href="https://github.com/cybertec-postgresql/today-i-learned-bot">Bot Repository</a>
</p>

## Table of Contents

## How to Use

### 1. Prerequisites

- [Git LFS](https://git-lfs.github.com)
- [Docker](https://docs.docker.com/install)
- [Docker-compose](https://docs.docker.com/compose/install)

### 2. Setup

```bash
# Clone repository
git clone git@github.com:cybertec-postgresql/today-i-learned-content.git

# Change into the directory
cd today-i-learned-content
git lfs pull
```
> Before running `docker-compose`, make sure that the current working directory does not contain /usr or /home or a link to your ~. The mount option `:Z` will result in the addition of the `svirt_sandbox_file_t` tag to all directories and folders that contained (recursively) in the current working directory.

> If you're unsure, ask somebody who knows about SELinux for assistance. Or read [this](http://www.projectatomic.io/blog/2016/03/dwalsh_selinux_containers/).

```bash
# Start docker container for previews
docker-compose up --build
```

### 3. Add yourself as an author

(It might be the case, that you've already be added to the authors list.)
Edit the file located under [./authors/authors.yml](./authors/authors.yml) and add yourself to the authors list. **Push these changes now, if they are in a content PR, they will get deleted.**

### 4. Write a post

New posts have to be written in [./posts/TEMPLATE/index.md](./posts/TEMPLATE/index.md). **This file should not be renamed or moved to a different location.** The normal github flavoured markdown syntax can be used.

To preview the newly created post visit [http://localhost:8000](http://localhost:8000). Now all that is left to do is create a new Pull Request and label it with "Content 📖" (or even with "Priority ❗").

### 5. Approval

The newly created pull request is proofread by one (or multiple) proofreaders and then approved. Daily at 12:00 GMT+0 one random post is automatically selected and published!

That's it!
