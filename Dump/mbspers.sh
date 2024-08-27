#!/usr/bin/env sh

echo $(/sbin/iw wlp1s0 station dump | perl -lne 'print if /tx bitrate/ || /rx bitrate/ ..  s/^\s+|\s+$//g')
