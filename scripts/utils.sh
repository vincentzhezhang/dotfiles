#! /usr/bin/env bash

__.log()
{
  >&2 echo "$*"
}

__.log_success()
{
  >&2 echo -e "\\e[32m$*\\e[0m"
}

__.log_info()
{
  >&2 echo -e "\\e[36m$*\\e[0m"
}

__.log_warning()
{
  >&2 echo -e "\\e[33m$*\\e[0m"
}

__.log_error()
{
  >&2 echo -e "\\e[1;31m$*\\e[0m"
}
