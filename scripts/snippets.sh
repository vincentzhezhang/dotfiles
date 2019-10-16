#! /usr/bin/env bash

# TODO
# - sounds like a good chance to make use of SQLite, because
#   - easy to implement meta info, e.g. language, tags
#   - easy to query because it's SQL
#   - easy to manage because it's a single file db
# batch rename files
for i in ./*.py; do if [[ ! "$i" == *__* ]]; then echo "${i//\.py/_schema.py}"; fi ; done
