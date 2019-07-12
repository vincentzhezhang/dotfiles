#! /usr/bin/env bash

if ! hash docker > /dev/null 2>&1; then
  return 0
fi

docker_clean()
{
  docker images prune --filter 'dangling=true'
  docker volume prune --filter 'dangling=true'
}
