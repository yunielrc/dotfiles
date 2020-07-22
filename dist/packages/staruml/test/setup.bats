load test_helper


@test 'should install staruml & config' {
  env PKG_CONTENT="${PKGS_PATH}/staruml/content" bash ../setup

  local -r name='StarUML'
  local -r app_image="${name}.AppImage"
  local -r app_icon="${name,,}.png"
  local -r app_desktop="${name}.desktop"

  type -P $app_image

  local -r dest_base_dir="$(realpath ~/.local)"
  local -r app_image_dest_dir="${dest_base_dir}/bin"
  local -r app_desktop_dest_dir="${dest_base_dir}/share/applications"
  local -r app_icon_dest_dir="${dest_base_dir}/share/icons"

  [[ -f "${app_image_dest_dir}/${app_image}" ]]
  [[ -f "${app_icon_dest_dir}/${app_icon}" ]]
  [[ -f "${app_desktop_dest_dir}/${app_desktop}" ]]

  run env PKG_CONTENT="${PKGS_PATH}/staruml/content" bash ../setup

  assert_output --partial "${app_image} currently installed"
}
