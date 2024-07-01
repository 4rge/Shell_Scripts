#!/usr/bin/env bash

echo z3fold >> /etc/initramfs-tools/modules
echo lz4 >> /etc/initramfs-tools/modules
echo lz4_compress >> /etc/initramfs-tools/modules
update-initramfs -u
update-grub
