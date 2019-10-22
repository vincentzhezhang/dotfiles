#! /usr/bin/env bash

echo 'Start updating kubeval...'
wget --quiet --show-progress --output-document=- https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz | tar -C /sandbox/vincent.zhang/bin/ -xzf -
echo 'Done'
