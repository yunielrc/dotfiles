# BASE
# add /etc/hosts
dotf-i root-config
# config network, add vpn
dotf-i network-config

if [[ "${INSTALL_WITH_VPN:-}" == true ]]; then
  # LOAD NETWORK CONFIG
  nmcli conn up "$NETWORK_CONFIG_CONN_VPN" || exit $?
fi

apt-ug
dotf-i brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
dotf-i rust && PATH="${PATH}:${HOME}/.cargo/bin"
# apt-i ruby-full
# :BASE

echoc '> APT packages'
# timeshift backup
# sudo add-apt-repository -y ppa:teejee2008/ppa
# apt-i timeshift
# Basic GL utilities built by Mesa, including glxinfo and glxgears
apt-i mesa-utils
# Tools for debugging the Intel graphics driver
apt-i intel-gpu-tools
# Displays an indented directory tree, in color
apt-i tree
# Peek - an animated GIF recorder
sudo add-apt-repository -y ppa:peek-developers/stable
apt-i peek
# Perl script to wake up computers
apt-i wakeonlan
# displays the percentage of copied data
apt-i progress
# The log file navigator
apt-i lnav
# The Silver Searcher is grep-like program implemented by C
apt-i silversearcher-ag
# Uses the GNU readline library to allow the editing of keyboard input
# for any other command
apt-i rlwrap
# Monitor the progress of data through a pipe
apt-i pv
# Packages essential for building
apt-i build-essential
# Growing collection of the Unix tools
apt-i moreutils
# Gnome simple configuration storage system - graphical editor
apt-i dconf-editor
# Graphical package management tool
apt-i synaptic
# Commonly used media codecs and fonts for Ubuntu
sudo debconf-set-selections <<<'ttf-mscorefonts-installer       msttcorefonts/accepted-mscorefonts-eula boolean true'
apt-i ubuntu-restricted-extras
# Robust, modular log coloriser
apt-i ccze
# Record and share your terminal sessions
apt-i asciinema
# Network utility to retrieve files from the web
apt-i wget
# Command line tool for transferring data with URL syntax
apt-i curl
# Compression utilities
apt-i zip unzip rar unrar p7zip-full p7zip-rar
# Portable bandwidth monitor and rate estimator
apt-i bmon
# NFS support files common to client and server
apt-i nfs-common
# java
apt-i default-jre
# Video media players
apt-i vlc
apt-i mpv
# Advanced GTK+ color picker
apt-i gpick
# Screencast and screenshot application
apt-i kazam
# HP Linux Printing and Imaging System
# apt-i hplip hplip-gui
# x86 Virtualization solution
apt-i virtualbox virtualbox-guest-additions-iso
# Pinta is an easy to use drawing/editing program
apt-i pinta
# Realistic first-person shooter
apt-i assaultcube
# ...
apt-i fortune cowsay
# apt-i gimp gimp-help-en gimp-help-es

echoc '>> CTF tools'

# Command-line tools for building TCP client-server applications
# apt-i ucspi-tcp
# Utility for managing network connections
apt-i netcat
# Analyzing and reporting on tcpdump (or other libpcap) dump files
apt-i tcptrace
# Captures data transmitted as part of TCP connections
apt-i tcpflow
# Multipurpose relay for bidirectional data transfer
apt-i socat
# Utility for network exploration or security auditing
apt-i nmap

echoc '> BREW packages'
# Lightweight and flexible command-line JSON processor
brew-i jq
# A small utility to create JSON objects
brew-i jo
# Command-line JSON processing tool
brew-i fx
# Search tool like grep and The Silver Searcher
brew-i rg
# Modern replacement for 'ls'
brew-i exa
# Modern replacement for ps written by Rust
brew-i procs
# Intuitive find & replace CLI
brew-i sd
# More intuitive version of du in rust
brew-i dust
# Very fast implementation of tldr in Rust
brew-i tealdeer # tldr
# A TUI system monitor written in Rust
brew tap cjbassi/ytop
brew-i ytop
# Command-line tool for generating regular expressions
brew-i grex
# Interactive terminal based UI application for tracking cryptocurrencies
brew-i cointop
# Rainbows and unicorns in your console!
brew-i lolcat
# Cross-platform monitoring tool
brew-i glances
# Search tool like grep, but optimized for programmers
brew-i ack

echoc '>> Development'
# A framework for managing and maintaining multi-language pre-commit hooks
# brew-i pre-commit
# GIT quick statistics
brew-i git-quick-stats
# Program that allows you to count code, quickly
brew-i tokei
# Human-friendly CLI HTTP client for the API era
# https://github.com/httpie/httpie#examples
brew-i httpie
# Lazier way to manage everything docker
brew-i lazydocker

echoc '> CARGO packages'

# A tool to analyze file system usage written in Rust
cargo install dutree

echoc '> DOTFILES packages'

dotf-i home-config

echoc '>> BASHC'

echoc '>>> Themes'
# The cross-shell prompt for astronauts
dotf-i starship
apt-ca
echoc '>> Tools'
# Clone of cat(1) with syntax highlighting and Git integration
dotf-i bat
# It's an interactive Unix filter for command-line
dotf-i fzf
# Interactive cheatsheet tool for the command-line
dotf-i navi
# Clone of ls with colorful output, file type icons, and more
dotf-i lsd
# Tiny, lightning fast, feature-packed file manager
dotf-i nnn
# Automate tasks on the local network
dotf-i lan-bot

echoc '>> Video & Streaming'
# Celluloid (formerly GNOME MPV)
dotf-i celluloid
# Versatile DVD ripper and video transcoder
dotf-i handbrake
# Watch Movies and TV Shows instantly
dotf-i popcorn-time
# Watch videos, movies, TV series and TV channels instantly
dotf-i stremio
# Download video and audio content from YouTube
dotf-i 4kvideodownloader

echoc '>> Web apps'
# Web apps
dotf-i webapps
# Local Network apps
dotf-i lanapps

echoc '>> Development'
dotf-i git --force
# Node.js event-based server-side javascript engine
dotf-i node --force
# Vi IMproved - enhanced vi editor
dotf-i vim8+
# Pack, ship and run any application as a lightweight container
dotf-i docker
# ...
dotf-i vscode
# The Collaboration Platform for API Development
dotf-i postman
# Design, debug, and test APIs
dotf-i insomnia
# ...
dotf-i aws-cli
# A sophisticated software modeler for agile and concise modeling
dotf-i staruml
# Docker container management interface
dotf-i portainer
# Manage virtual machine environments in a single workflow
dotf-i vagrant
# Open source editor fully dedicated to OpenAPI-based APIs
dotf-i swagger-editor

echoc '>> Internet'
dotf-i google-chrome
# Cloud-based instant messaging
dotf-i telegram
# Nauta session management service
dotf-i sweet-nauta-server #

echoc '>> Disk Tools'
# watches I/O usage
dotf-i iotop

echoc '>> Network Tools'
# Net top tool grouping bandwidth per process
dotf-i nethogs
# Net top tool grouping bandwidth per process
# dotf-i bandwhich # hangs, inverts upload and download data
# Display an interface's bandwidth usage
dotf-i iftop

echoc '>> Finance'
# Bitcoin Wallet
dotf-i electrum

echoc '>> Text editors'
# A minimal Markdown reading & writing app
dotf-i typora

echoc '> Configure network:'
echo '$ nm-connection-editor'

echoc '> For adding more tools visit:'
cat <<EOF
50 Things to Do After installing Ubuntu 20.04 - https://youtu.be/MNX7HgcWqHc
https://github.com/alebcay/awesome-shell
https://github.com/agarrharr/awesome-cli-apps
https://github.com/herrbischoff/awesome-command-line-apps
https://github.com/mathiasbynens/dotfiles/blob/main/brew.sh
EOF
