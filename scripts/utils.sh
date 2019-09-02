#! /usr/bin/env bash

__.log()
{
  >&2 echo ">>> $@"
}

__.log_success()
{
  >&2 echo -e "\\e[32m>>> [$(basename $0):${BASH_LINENO[1]}] $@\\e[0m"
}

__.log_info()
{
  >&2 echo -e "\\e[36m>>> [$(basename $0):${BASH_LINENO[1]}] $@\\e[0m"
}

__.log_warning()
{
  >&2 echo -e "\\e[33m>>> [$(basename $0):${BASH_LINENO[1]}] $@\\e[0m"
}

__.log_error()
{
  >&2 echo -e "\\e[1;31m>>> [$(basename $0):${BASH_LINENO[1]}] $@\\e[0m"
}

# vim: set autoindent expandtab number textwidth=119 tabstop=2 shiftwidth=2 :
