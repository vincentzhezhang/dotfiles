#! /usr/bin/env bash
# shellcheck disable=SC2155

# TODO
# - make this a proper plugin
set -e

get_tmux_option()
{
  local option_name="$1"
  local default_option_value="$2"
  local option_value=$(tmux show-option -gqv "$option_name")

  if [[ -n "$option_value" ]]; then
    echo "$option_value"
  else
    echo "$default_option_value"
  fi
}

set_tmux_option()
{
  local option_name="$1"
  local option_value="$2"

  tmux set-option -g "$option_name" "$option_value"
}

here="${BASH_SOURCE[0]}"

default_copy_mode_border_style='fg=yellow'
default_normal_mode_border_style='fg=cyan'

copy_mode_border_style=$(get_tmux_option '@copy_mode_border_style' "$default_copy_mode_border_style")
normal_mode_border_style=$(get_tmux_option '@normal_mode_border_style' "$default_normal_mode_border_style")

tmux set-hook -g client-session-changed "run-shell '$here #{pane_in_mode}'"
tmux set-hook -g pane-mode-changed "run-shell '$here #{pane_in_mode}'"
tmux set-hook -g window-pane-changed "run-shell '$here #{pane_in_mode}'"

main()
{
  local mode="$1"
  if [[ "$mode" == '1' ]]; then
    set_tmux_option 'pane-active-border-style' "$copy_mode_border_style"
  else
    set_tmux_option 'pane-active-border-style' "$normal_mode_border_style"
  fi
}
main "$@"
