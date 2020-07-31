#!/usr/bin/env bash

set -euE

export DEBIAN_FRONTEND=noninteractive

set -o allexport
. ~/.dotfiles/.env
set +o allexport

sudo -s <<EOF
apt-get update -y
apt-get install -y --no-install-recommends ubuntu-desktop-minimal
apt-get install -y tigervnc-standalone-server tigervnc-common xrdp
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
# echo "$VNC_PASSWORD" | vncpasswd -f > ~/.vnc/passwd, # I don't know why this don't work
# autostart tigervnc server
# cat <<EOF | sudo tee /lib/systemd/system/vncserver@.service
# [Unit]
# Description=Start TightVNC server at startup
# After=syslog.target network.target

# [Service]
# Type=forking
# User=${USER}
# Group=${USER}

# WorkingDirectory=/home/${USER}

# PIDFile=/home/sammy/.vnc/%H:%i.pid
# ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
# ExecStart=/usr/bin/vncserver :%i -passwd /home/${USER}/.dotfiles/passwd -localhost no -geometry 1024x768 -depth 32
# ExecStop=/usr/bin/vncserver -kill :%i

# [Install]
# WantedBy=multi-user.target
# EOF

# sudo systemctl daemon-reload
# sudo systemctl enable vncserver@1.service
# sudo systemctl start vncserver@1.service

cat <<EOF > ~/vncserver-start
#!/usr/bin/env bash
vncserver :1 -passwd /home/${USER}/.dotfiles/passwd -localhost no -geometry 1024x768 -depth 32
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

sudo touch /run/xrdp/xrdp.pid
sudo chmod 660 /run/xrdp/xrdp.pid
sudo systemctl enable xrdp --now

~/vncserver-start
~/vncserver-list
# disown %%
