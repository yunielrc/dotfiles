#!/usr/bin/env bash

# Environment

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"

# Completions

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    # shellcheck disable=SC1090
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
    # shellcheck disable=SC1090
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi
