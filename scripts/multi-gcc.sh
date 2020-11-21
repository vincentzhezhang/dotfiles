#! /usr/bin/env bash

main() {
  for name in gcc g++; do
    i=0
    find /usr/bin/ -name "$name-[0-9.]*" | while read -r path; do
      ((i++))
      cmd="sudo update-alternatives --install /usr/bin/$name $name $path $((i * 10))"
      >&2 echo "$cmd"
      eval "$cmd"
    done
  done
}

main
