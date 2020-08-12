# base
dotf-i bashc
dotf-i brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
dotf-i rust
PATH="${PATH}:${HOME}/.cargo/bin"
apt-i ruby-full
# :base

echoc '>> APT packages'

apt-i nfs-common
apt-i default-jre
apt-i ubuntu-restricted-extras
# apt-i ttf-mscorefonts-installer
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
brew install bandwhich
brew install grex
brew install lsd
brew install cointop
brew install navi
echo -e '\nsource <(navi widget bash)' >> ~/.bashrc

echoc '>> CARGO packages'

cargo install dutree
# cargo install exa
# cargo install procs
# cargo install du-dust
# cargo install starship

echoc '>> DOTFILES packages'

dotf-i core-config

echoc 'Tools'
dotf-i fzf

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
