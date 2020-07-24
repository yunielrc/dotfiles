# base
dotf-i bashc
dotf-i apt
dotf-i brew
dotf-i rust
PATH="${PATH}:${HOME}/.cargo/bin"
# :base

echoc '>> APT packages'

apt-i nfs-common
apt-i default-jre
apt-i ubuntu-restricted-extras
apt-i ttf-mscorefonts-installer
apt-i lm-sensors
apt-i dconf-editor
apt-i vlc
apt-i mpv
apt-i gpick
apt-i kazam
apt-i gnome-shell-pomodoro
# apt-i hplip hplip-gui
# apt-i virtualbox virtualbox-guest-additions-iso
# apt-i pinta
# apt-i assaultcube
# apt-i gimp gimp-help-en gimp-help-es

echoc '>> BREW packages'

brew install fd
brew install rg
brew install fzf
brew install bat

echoc '>> CARGO packages'

cargo install dutree

echoc '>> DOTFILES packages'

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
#  dotf-i docker
dotf-i staruml

# TODO: agregar appimages al PATH
# TODO: hacer compatible entorno de prueba con appimages
# TODO: Telegram no aparece
