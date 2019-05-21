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
  local session="$3"

  if [[ -n "$session" ]]; then
    tmux set-option -t "$session" "$option_name" "$option_value"
  else
    tmux set-option -g "$option_name" "$option_value"
  fi
}

here="${BASH_SOURCE[0]}"

default_copy_mode_border_style='fg=yellow'
default_normal_mode_border_style='fg=cyan'

copy_mode_border_style=$(get_tmux_option '@copy_mode_border_style' "$default_copy_mode_border_style")
normal_mode_border_style=$(get_tmux_option '@normal_mode_border_style' "$default_normal_mode_border_style")

tmux set-hook -g client-session-changed "run-shell '$here #{pane_in_mode} #{session_name}'"
tmux set-hook -g pane-mode-changed "run-shell '$here #{pane_in_mode} #{session_name}'"
tmux set-hook -g window-pane-changed "run-shell '$here #{pane_in_mode} #{session_name}'"

main()
{
  local pane_in_mode="$1"
  local session_name="$2"
  if [[ "$pane_in_mode" == '1' ]]; then
    set_tmux_option 'pane-active-border-style' "$copy_mode_border_style" "$session_name"
  else
    set_tmux_option 'pane-active-border-style' "$normal_mode_border_style" "$session_name"
  fi
}
main "$@"
