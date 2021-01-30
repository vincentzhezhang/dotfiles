#! /usr/bin/env bash

IMAGE_NAME=dumb_status_line

docker container rm -f "$IMAGE_NAME"

docker run \
  --detach \
  --network=host \
  --name="$IMAGE_NAME" \
  --user="$(id --user):$(id --group)" \
  --volume "$(realpath ~/.ssh/):/home/$(whoami)/.ssh/:ro" \
  --volume "/etc/passwd:/etc/passwd:ro" \
  dsl
