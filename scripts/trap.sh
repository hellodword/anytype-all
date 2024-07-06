#! /usr/bin/env bash

# https://stackoverflow.com/a/76448047

pid=
trap 'echo EXIT; [[ $pid ]] && kill $pid; exit' EXIT
echo Starting script
exec "$@" & pid=$!
wait
pid=
