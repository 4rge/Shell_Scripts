#!/usr/bin/env bash

red='\x1B[31m%s\e[0m\n'
green='\x1B[32m%s\e[0m\n'
blue='\x1B[34m%s\e[0m\n'
yellow='\x1B[33m%s\e[0m\n'

BINDIR="/usr/local/bin/"
DIR="$2"

function chklnk() {
for LINK in $(ls $BINDIR) ; do
  if [ -L "${BINDIR}${LINK}" ] ; then
    if [ -e "${BINDIR}${LINK}" ] ; then
      printf $green "Good link "
    else
      printf $red "Broken link "
    fi
  elif [ -e "${BINDIR}${LINK}" ] ; then
    printf $blue "Executable "
  else
    printf $yellow "Missing "
  fi
  echo -e "$BINDIR$LINK\n"
done
}

function mklnk() {
  LNKNAME=$(echo "$(basename ${DIR%.*})")
  sudo ln -sTf $(pwd)/${DIR} ${BINDIR}${LNKNAME}
  printf $green "${LNKNAME} Configured" || printf $red "Error Configuring ${LNKNAME}"
}

function rmlnk() {
  sudo unlink ${BINDIR}${DIR} && printf $red "${DIR} Removed" || printf $yellow "Error Removing ${DIR}"
}

case $1 in
  "") chklnk ;;
  -m|--make) mklnk ;;
  -r|--remove) rmlnk ;;
esac
