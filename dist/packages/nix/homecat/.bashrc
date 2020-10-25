# @CAT_SECTION_NIX
if type -P nix-env >/dev/null; then
  export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"
fi
# :@CAT_SECTION_NIX
