# dotfiles

## About

Install dotfiles and apps

### Prerequisites

Install

```sh
$ sudo apt update -y
$ sudo apt install -y git
```

### Installing

Clone the repo

```sh
$ git clone git@github.com:yunielrc/dotfiles.git ~/.dotfiles
```

Edit `.env` file located in `dist` folder

```sh
$ cd ~/.dotfiles/dist
$ cp .env.template .env
$ vim .env
```

Install the dotfiles

```sh
$ cd ~/.dotfiles/dist
$ ./dotfiles desktop # `desktop` from `cm` (configuration management) folder
```

You can see installation errors log:

```sh
$ tail -fn 20 ~/.dotfiles.err.log
```
