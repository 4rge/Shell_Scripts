#!/usr/bin/env sh

/sbin/iw wlp1s0 station dump | grep 'tx bitrate' | awk '{print $3}'
