load test_helper


@test 'should install telegram & config' {
  env PKG_CONTENT="${PKGS_PATH}/telegram/content" bash ../setup

  local -r name='Telegram'
  local -r app_image="${name}"
  local -r app_icon="${name,,}.png"
  local -r app_desktop="telegramdesktop.desktop"

  type -P $app_image

  local -r dest_base_dir="$(realpath ~/.local)"
  local -r app_image_dest_dir="${dest_base_dir}/bin"
  local -r app_desktop_dest_dir="${dest_base_dir}/share/applications"
  local -r app_icon_dest_dir="${dest_base_dir}/share/icons"

  [[ -f "${app_image_dest_dir}/${app_image}" ]]
  [[ -f "${app_image_dest_dir}/Updater" ]]
  [[ -f "${app_icon_dest_dir}/${app_icon}" ]]
  [[ -f "${app_desktop_dest_dir}/${app_desktop}" ]]

  run env PKG_CONTENT="${PKGS_PATH}/telegram/content" bash ../setup

  assert_output --partial "${app_image} currently installed"
}
