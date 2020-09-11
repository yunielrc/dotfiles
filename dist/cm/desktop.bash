# BASE
# dotf-i apt-cacher-ng # must be before apt-ug
apt-ug
dotf-i brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
dotf-i rust && PATH="${PATH}:${HOME}/.cargo/bin"
# apt-i ruby-full
# :BASE

echoc '> APT packages'

# timeshift backup
# sudo add-apt-repository -y ppa:teejee2008/ppa
# apt-i timeshift
#
# ...
apt-i dconf-editor
# gui package manager
apt-i synaptic
# codecs & fonts
sudo debconf-set-selections <<<'ttf-mscorefonts-installer       msttcorefonts/accepted-mscorefonts-eulaboolean true'
apt-i ubuntu-restricted-extras
# Command-line JSON processor
apt-i jq
# Log colorizer
apt-i ccze
# Cross-platform monitoring tool
apt-i glances
# Easily record/replay terminal sessions
apt-i asciinema
# ...
apt-i wget
# ...
apt-i curl
# ...
apt-i zip unzip rar unrar p7zip-full p7zip-rar
# Bandwidth monitor
apt-i bmon
# NFS client & server
apt-i nfs-common
# java
apt-i default-jre
# ...
apt-i vlc
# video player
apt-i mpv
# desktop color picker
apt-i gpick
# screen recorder
apt-i kazam
# hp printer drivers
apt-i hplip hplip-gui
# virtualization
apt-i virtualbox virtualbox-guest-additions-iso
# paint
apt-i pinta
# shooter game
apt-i assaultcube
# Simplified man pages with examples
apt-i tldr
# ...
apt-i fortune cowsay
# apt-i gimp gimp-help-en gimp-help-es

echoc '> BREW packages'
brew-i fd
brew-i rg
brew-i bat
brew-i exa
brew-i procs
brew-i sd
brew-i dust
brew-i tealdeer # tldr
brew-i tokei
brew tap cjbassi/ytop
brew-i ytop
brew-i grex
brew-i cointop
brew-i lolcat

echoc '> CARGO packages'

cargo install dutree
# cargo install exa
# cargo install procs
# cargo install du-dust
# cargo install starship

echoc '> DOTFILES packages'

# dotf-i backup-home
dotf-i root-config
dotf-i home-config
dotf-i home-scripts

echoc '>> bash'

echoc '>>> bash themes'
dotf-i starship
dotf-i bash-git-prompt
dotf-i sexy-bash-prompt

echoc '>> Tools'
dotf-i fzf
dotf-i navi
dotf-i lsd
dotf-i lan-bot

echoc '>> Video & Streaming'
dotf-i celluloid
dotf-i handbrake
dotf-i popcorn-time
dotf-i stremio
dotf-i 4kvideodownloader

echoc '>> Web apps'
dotf-i webapps
dotf-i lanapps

echoc '>> Internet'
dotf-i google-chrome
dotf-i telegram
dotf-i sweet-nauta-server

echoc '>> Disk Tools'
dotf-i iotop

echoc '>> Network Tools'
dotf-i nethogs
dotf-i bandwhich
dotf-i iftop

echoc '>> Finance'
dotf-i electrum

echoc '>> Text editors'
dotf-i typora

echoc '>> Development'
dotf-i git --force
dotf-i node
dotf-i vim8+
dotf-i docker
dotf-i vscode
dotf-i postman
dotf-i insomnia
dotf-i aws-cli
dotf-i staruml
dotf-i portainer
dotf-i vagrant
dotf-i swagger-editor

echoc '> REVIEW'
inf '50 Things to Do After installing Ubuntu 20.04 - https://youtu.be/MNX7HgcWqHc'
