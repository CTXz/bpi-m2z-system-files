#!/usr/bin/env bash

#
# Copyright (C) 2023 Patrick Pedersen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# 
# Usage: $ sudo ./install.sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Compares two directories and returns wich files in the second directory
# will get overwritten by the first.
# Essentially, it simply returns the intersection of the two directories.
overwritten_files() {
    # directory 1
    dir1=$1

    # directory 2
    dir2=$2

    # find files in directory 1 recursively
    files1=($(find $dir1 -type f))

    # variable to store the common files
    RET=()

    # iterate over files in directory 1
    for file1 in "${files1[@]}"; do
        rfile=$(echo $file1 | sed "s|$dir1||")
        ret=$(readlink -m "$dir2/$rfile")
        # check if file exists in directory 2
        if [ -f $ret ]; then
            # add file name to the RET array
            RET+=("$ret")
        fi
    done
}

# Check if script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Check which files will be overwritten
overwritten=()
echo "WARNING: The following files will be overwritten:"
overwritten_files $SCRIPT_DIR/etc /etc
overwritten+=($RET)
overwritten_files $SCRIPT_DIR/usr /usr
overwritten+=($RET)
overwritten_files $SCRIPT_DIR/var /var
overwritten+=($RET)

for file in "${overwritten[@]}"; do
    echo $file
done

while true; do
  echo "Do you want to continue? [Yy/Nn]"
  read -r answer

  case $answer in
    [Yy]* ) break;;
    [Nn]* ) exit 1;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Copy files

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
