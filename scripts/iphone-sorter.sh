#! /usr/bin/env bash

_detect_path() {
  local mount_path
  mount_path=$(mount | grep gvfs | grep user_id="$(id -u)" | awk '{print $3}')

  if [[ -d "$mount_path" ]]; then
    echo "$mount_path"
  else
    >&2 echo "Can't find iPhone mount, please double check!"
  fi
}

main() {
  local mount_path
  local photo_root

  mount_path=$(_detect_path)
  photo_root=$(find "$mount_path" -maxdepth 1 -type d -name '*photo*')

  echo "$mount_path"
  echo "$photo_root"

  find "$photo_root" -type f -not -name '*.HEIC' -not -name '*.AAE' -print0 | xargs -0 -I _ mv "_" "/sandbox/vincent/Pictures/ios/"
}

main
