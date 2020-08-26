# base
dotf-i brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # brew must be before bashc
dotf-i bashc
dotf-i rust && PATH="${PATH}:${HOME}/.cargo/bin"
apt-i ruby-full
# :base

dotf-i backup-home

echoc '>> APT packages'

apt-i nfs-common
apt-i default-jre
# apt-i ubuntu-restricted-extras # caution: this pkg shows interactive dialog
# apt-i ttf-mscorefonts-installer # caution: this pkg shows interactive dialog
apt-i lm-sensors
apt-i dconf-editor
apt-i vlc
apt-i mpv
apt-i gpick
apt-i kazam
apt-i gnome-shell-pomodoro
apt-i hplip hplip-gui
apt-i virtualbox virtualbox-guest-additions-iso
apt-i pinta
apt-i assaultcube
apt-i tldr
apt-i most
apt-i gpg
# apt-i gimp gimp-help-en gimp-help-es

echoc '>> BREW packages'
# so slow executin with starship prompt: $ time for i in $(seq 1 1000000); do [ 1 = 1 ]; done
# brew install starship
# echo -e '\neval "$(starship init bash)"' >> ~/.bashrc
brew install fd
brew install rg
brew install bat
brew install exa
brew install procs
brew install sd
brew install dust
brew install tealdeer
brew install tokei
brew tap cjbassi/ytop
brew install ytop
brew install tealdeer
brew install grex
brew install cointop

echoc '>> CARGO packages'

cargo install dutree
# cargo install exa
# cargo install procs
# cargo install du-dust
# cargo install starship

echoc '>> DOTFILES packages'

echoc 'Tools'
dotf-i fzf
dotf-i bandwhich
dotf-i navi
dotf-i lsd

echoc 'Video'
dotf-i celluloid
dotf-i handbrake
dotf-i popcorn-time
dotf-i stremio

echoc 'Web apps'
dotf-i webapps

echoc 'Internet'
dotf-i google-chrome
dotf-i 4kvideodownloader
dotf-i telegram
dotf-i sweet-nauta-server

echoc 'Network Tools'
dotf-i nethogs

echoc 'Finance'
dotf-i electrum

echoc 'Text editors'
dotf-i typora

echoc 'Development'
dotf-i node
dotf-i vscode
dotf-i postman
dotf-i insomnia
dotf-i aws-cli
dotf-i docker
dotf-i staruml

echoc 'Home Config'
dotf-i home-config
dotf-i home-scripts

echoc 'Hosted Network services'
dotf-i apt-cacher-ng
