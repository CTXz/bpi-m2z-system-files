#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

cp -v $SCRIPT_DIR/etc /etc
cp -v $SCRIPT_DIR/usr /usr
cp -v $SCRIPT_DIR/var /var

echo "System files installed!"