#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

cp -v -r $SCRIPT_DIR/etc/* /etc/

if [ $? -ne 0 ]
  then echo "Failed to copy $SCRIPT_DIR/etc to /etc"
  exit 1
fi

cp -v -r $SCRIPT_DIR/usr/* /usr/

if [ $? -ne 0 ]
  then echo "Failed to copy $SCRIPT_DIR/usr to /usr"
  exit 1
fi

cp -v -r $SCRIPT_DIR/var/* /var/

if [ $? -ne 0 ]
  then echo "Failed to copy $SCRIPT_DIR/var to /var"
  exit 1
fi

echo "System files installed!"
