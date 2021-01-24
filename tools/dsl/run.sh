#! /usr/bin/env bash

docker run \
  --interactive \
  --tty \
  --network=host \
  --user="$(id --user):$(id --group)" \
  --volume "$(realpath ~/.ssh/):/home/$(whoami)/.ssh/:ro" \
  --volume "/etc/passwd:/etc/passwd:ro" \
  dsl
