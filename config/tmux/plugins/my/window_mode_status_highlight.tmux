#! /usr/bin/env bash

#
# use different colours in window-status to represent different states of the
# window
#

set -e

source ./utils

here="${BASH_SOURCE[0]}"

echo "window sourced!" >> /tmp/ttt.log

tmux set-hook -g after-resize-pane "run-shell '$here #{window_zoomed_flag} #{session_name}'"
# zoom state will be reset on split
tmux set-hook -g after-split-window "run-shell '$here #{window_zoomed_flag} #{session_name}'"

main()
{
  echo "window executed!" >> /tmp/ttt.log
  local window_zoomed_flag="$1"
  local session_name="$2"

  if [[ "$window_zoomed_flag" == '1' ]]; then
    set_tmux_option 'window-status-current-format' "#[fg=yellow,bg=brightblack] #{window_index} #{window_flags} " "$session_name"
  else
    set_tmux_option 'window-status-current-format' "#[fg=cyan,bg=brightblack] #{window_index} #{window_flags} " "$session_name"
  fi
}

main "$@"
