#! /usr/bin/env bash

__.log()
{
  local color_code="${1:?}"
  local filename="${BASH_SOURCE[2]:-stdin}"
  local lineno="${BASH_LINENO[1]}"
  shift;

  >&2 echo -e "\\e[${color_code}m>>> [$filename:$lineno] $*\\e[0m"
}

__.log_success()
{
  __.log 32 "$@"
}

__.log_info()
{
  __.log 36 "$@"
}

__.log_warning()
{
  __.log 33 "$@"
}

__.log_error()
{
  __.log '1;31' "$@"
}

# vim: set autoindent expandtab number textwidth=119 tabstop=2 shiftwidth=2 :
