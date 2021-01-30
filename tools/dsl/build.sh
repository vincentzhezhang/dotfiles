#! /usr/bin/env bash

docker build \
  --build-arg http_proxy=http://0.0.0.0:3213 \
  --network=host \
  --tag dsl \
  .
