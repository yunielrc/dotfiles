load test_helper


@test 'should install telegram & config' {
  bash ../setup

  local -r name='Telegram'
  local -r app_image="${name}"
  local -r app_icon="${name,,}"
  local -r app_desktop="telegramdesktop.desktop"

  local -r dest_base_dir="$(realpath ~/.local)"
  local -r app_image_dest_dir="${dest_base_dir}/bin"
  local -r app_desktop_dest_dir="${dest_base_dir}/share/applications"
  local -r app_icon_dest_dir="${dest_base_dir}/share/icons"

  [[ -f "${app_image_dest_dir}/Telegram/${app_image}" ]]
  [[ -f "${app_image_dest_dir}/Telegram/Updater" ]]
  [[ -f "${app_icon_dest_dir}/${app_icon}.png" ]]
  [[ -f "${app_desktop_dest_dir}/${app_desktop}" ]]

  bash ../setup | grep -q "${app_image} currently installed"
}
