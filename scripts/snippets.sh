#! /usr/bin/env bash

# batch rename files
for i in ./*.py; do if [[ ! "$i" == *__* ]]; then echo "${i//\.py/_schema.py}"; fi ; done
