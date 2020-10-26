#! /usr/bin/env bash

#
# use different colours in window-status to represent different states of the
# window
#
# TODO
# - more status?
#

set -exv

MY_TMUX_PLUGIN_LOG_PATH=${MY_TMUX_PLUGIN_LOG_PATH:-/tmp/my_tmux_plugins.log}

this_file="$(realpath --no-symlinks "${BASH_SOURCE[0]}")"

echo "Loading $this_file" >> "$MY_TMUX_PLUGIN_LOG_PATH"

here=$(dirname "$this_file")
utils_path="$here/utils"

echo "Sourcing utils: $utils_path" >> "$MY_TMUX_PLUGIN_LOG_PATH"

# shellcheck disable=SC1090
source "$utils_path"

tmux set-hook -g after-resize-pane "run-shell '$this_file #{window_zoomed_flag} #{session_name}'"
# zoom state will be reset on split
tmux set-hook -g after-split-window "run-shell '$this_file #{window_zoomed_flag} #{session_name}'"

main()
{
  echo "Executing $this_file" >> "$MY_TMUX_PLUGIN_LOG_PATH"
  local window_zoomed_flag="$1"
  local session_name="$2"

  if [[ "$window_zoomed_flag" == '1' ]]; then
    set_tmux_option 'window-status-current-format' "#[fg=brightblack,bg=yellow] #{window_index} #{window_flags} " "$session_name"
  else
    set_tmux_option 'window-status-current-format' "#[fg=cyan,bg=brightblack] #{window_index} #{window_flags} " "$session_name"
  fi
}

main "$@"
