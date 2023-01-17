# Banana Pi M2 Zero System Files

The following repository contains some linux configs, libs and other system files
for BPI series single-board computers and has been slighlty modfied to specifically
target the Banana Pi M2 Zero.

The original files can be found [here](https://github.com/BPI-SINOVOIP/BPI-files/tree/master/others/bpi-service), and as of now the only change lies in the specified board in the `/var/lib/bananapi/board.sh` file.

The directory contains various configuration files and scripts. Based on the file names, it appears that the files are used to configure various system settings such as network interfaces, display settings, and power management.

The primary reason for me to upload these files is, because they're also required to get GPIO access working.

## Installation

The repository contains a install script, which will copy all files to their respective locations.

> **WARNING:** The install script will will overwrite some existing file, in particular, it will overwrite `/etc/rc.local` which could contain some user defined commands.
> Due to this, it is highly recommended to install the files right after a fresh installation of the OS.

To install the files, simply run the following command:
```
$ sudo ./install.sh
```
