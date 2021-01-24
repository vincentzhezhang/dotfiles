#! /usr/bin/env bash

# --build-arg http_proxy=http://0.0.0.0:3213 \
docker build \
  --network=host \
  --tag dsl \
  .
