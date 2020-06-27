#!/usr/bin/env bash

err() {
  echo "ERROR> $*" >&2
}

inf() {
  echo "INFO> $*"
}

infn() {
  echo -n "INFO> $*"
}

debug() {
  [[ "$DEBUG" != true ]] && return 0;
  echo "DEBUG> $*"
}
