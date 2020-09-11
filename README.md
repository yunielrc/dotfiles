# dotfiles

## About

Install dotfiles and apps.
**You can adjust the dotfiles but you should keep in mind that they are personal.**

### Prerequisites

Install

```sh
 sudo apt update -y
 sudo apt install -y git
```

### Installing

Clone the repo

```sh
 git clone --recurse-submodules git@github.com:yunielrc/dotfiles.git ~/.dotfiles
```

Edit `.env` file located in `dist` folder

```sh
 cd ~/.dotfiles/dist
 cp .env.template .env
 vim .env
```

Install the dotfiles

```sh
 cd ~/.dotfiles/dist
 ./dotfiles desktop # `desktop` from `cm` (configuration management) folder
```

You can see installation errors log:

```sh
 tail -fn 20 ~/.dotfiles.err.log
```

## You can test before install

OS: ubuntu 20.04

### Prerequisites

before testing you need to do this:

```sh
 cd ~/.dotfiles/dist
 ./setup-devenv # setup your development environment
 vim .env # ... put your settings
```

### Testing

- **Local** testing inside **docker container**

```sh
# test specific dotfile
 ./dcrun test ./dist/packages/iftop/test/setup.bats
# test all dotfiles
 ./dcrun test
```

- **Remote** testing inside a **docker container** (reusable environment)

```sh
 vagrant up docker --provision --provider=aws
 vagrant ssh docker
# test specific dotfile
> on-remote $ ./dcrun test ./dist/packages/iftop/test/setup.bats
# test all dotfiles
> on-remote $ ./dcrun test
> on-remote $ exit
 vagrant halt -f docker # OR $ vagrant destroy -f docker
```

- **Remote** testing directly in the **virtual machine** (not reusable environment)

```sh
 vagrant up vm --provision --provider=aws
 vagrant ssh vm
# test specific dotfile
> on-remote $ ./scripts/test ./dist/packages/iftop/test/setup.bats
# test all dotfiles
> on-remote $ ./scripts/test
> on-remote $ exit
 vagrant destroy -f vm
```

- **Remote** testing gui apps directly in the **virtual machine with a vnc server** (not reusable environment)

```sh
 vagrant up vnc --provision --provider=aws
 vagrant ssh vnc
# test gui app setup
> on-remote $ ./scripts/test ./dist/packages/4kvideodownloader/test/setup.bats
# copy remote vm public ip
> on-remote $ dig +short myip.opendns.com @resolver1.opendns.com
> on-remote $ exit
 vncviewer DIG_OUTPUT_HERE:5901
# on remote: launch 4k video downloader app
# later, when testing is done run:
 vagrant destroy -f vnc
```

## Checklists

## Checklists

## Before PC disposing

- [ ] Backup personal data
- [ ] Backup gpg keys (E)
- [ ] Push private dotfiles (E)
- [ ] Push dotfiles
- [ ] Erase disk

## After installing the new PC

- [ ] Pull dotfiles
- [ ] Install dotf: gpg-backup, rsync-backup
- [ ] Copy and Restore gpg keys with gpg-backup (D)
- [ ] Pull private dotfiles (D)
- [ ] Install private dotfiles
- [ ] Restore apt cache with rsync-backup
- [ ] Install dotfiles (uses apt cache)
- [ ] Restore personal
- [ ] Install dotfiles
