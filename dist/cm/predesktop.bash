apt-u
# bashc & home-scripts can be installed with .env.template default values
dotf-i bashc
# install gpg-backup, rsync-backup
dotf-i home-scripts

if [[ "${INSTALL_APT_CACHER:-}" == true ]]; then
  dotf-i apt-cacher-ng
fi
