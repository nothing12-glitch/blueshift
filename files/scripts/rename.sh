#!/usr/bin/env bash
sed -i \
  -e 's/^NAME=.*/NAME="BlueShift Linux"/' \
  -e 's/^PRETTY_NAME=.*/PRETTY_NAME="BlueShift Linux"/' \
  /usr/lib/os-release
