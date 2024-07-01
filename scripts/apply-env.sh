#! /usr/bin/env bash

set -e

target="$1"

if [ ! -f "$target" ]; then
  echo "target not exist: $target"
  exit 1
fi

source .env

vars=($(compgen -v | grep '^ANY_'))

for i in ${!vars[@]}; do
  key="${vars[$i]}"
  value="${!key}"
  sed -i "s@\$$key@$value@g" "$target"
done
