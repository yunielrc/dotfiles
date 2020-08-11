#!/usr/bin/env bash

set -euEo pipefail

type -P vncserver &> /dev/null && {
  echo 'vncserver currently installed'
  exit 0
}

set -o allexport
. "${WORKDIR}/.env"
set +o allexport

export DEBIAN_FRONTEND=noninteractive

sudo -s <<EOF
apt-get update -y
apt-get install -y --no-install-recommends ubuntu-desktop-minimal
apt-get install -y tigervnc-standalone-server tigervnc-common
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
EOF

# Configure Gnome
cat <<EOF | sudo tee --append /etc/gdm3/custom.conf
# Enabling automatic login
  AutomaticLoginEnable = true
  AutomaticLogin = ${USER}
EOF
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.interface enable-animations false

# Configure TigerVNC server
[[ ! -d ~/.vnc ]] && mkdir ~/.vnc
cat <<'EOF' > ~/.vnc/xstartup
#!/bin/sh
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &
EOF
chmod 700 ~/.vnc/xstartup

cat <<EOF > ~/vncserver-start
#!/usr/bin/env bash
vncserver :1 -passwd ${WORKDIR}/passwd -localhost no -geometry 1024x768 -depth 32
EOF
chmod +x ~/vncserver-start

cat <<'EOF' > ~/vncserver-stop
#!/usr/bin/env bash
vncserver -kill :1
EOF
chmod +x ~/vncserver-stop

cat <<'EOF' > ~/vncserver-list
#!/usr/bin/env bash
vncserver -list
EOF
chmod +x ~/vncserver-list

cat <<'EOF'
Run:
$ vagrant ssh
on-remote$ ~/vncserver-start
on-remote$ ~/vncserver-list
on-remote$ ~/vncserver-stop
EOF

~/vncserver-start
~/vncserver-list
# disown %%


echo -e "\n>>RUN: vncviewer $(dig +short myip.opendns.com @resolver1.opendns.com):5901"
