#!/usr/bin/env $SHELL

cat "$HOME/.$(basename ${SHELL})rc" | grep $1
