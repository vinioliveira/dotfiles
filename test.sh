#!/bin/bash
# set -x #echo on

ruby_version="$(ruby --version | awk  '{print $2}')"

if [[ "$ruby_version" == "2.7"* ]]; then
  echo "Teste"
fi
