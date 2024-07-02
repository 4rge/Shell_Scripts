#!/bin/bash

red='\x1B[31m%s\e[0m\n'
green='\x1B[32m%s\e[0m\n'
blue='\x1B[34m%s\e[0m\n'
yellow='\x1B[33m%s\e[0m\n'
SEEHELP=Help
BINDIR="/usr/local/bin/"

Help() {
   # Display Help
   printf "A cli tool for quickly checking, making, and removing system links to $BINDIR"
   echo
   echo
   printf $yellow "Check links in $BINDIR"
   echo "Syntax: $(basename ${0}) or $(basename ${0}) [-c|-ck|--check]"
   echo 
   printf $yellow "Make or remove syslink in $BINDIR"
   echo "Syntax: $(basename ${0}) <filename> ([-m|-mk|--make] or [-r|-rm|--remove])"
   echo
   echo "Options:" 
   printf $blue "h|help         Print this Help."
   printf $green "m|mk|make     Verbose mode."
   printf $red "r|rm|remove     Print software version and exit."
   printf $yellow  "c|ck|check  Print the GPL license notification."
   echo

}

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
  if [ -z "${@:1}" ] ; then
    $SEEHELP
  else
    DIR="$1"
    LNKNAME=$(echo "$(basename ${DIR%.*})")
    sudo ln -sTf $(pwd)/${DIR} ${BINDIR}${LNKNAME}
    printf $green "${LNKNAME} Configured" || printf $red "Error Configuring ${LNKNAME}"
  fi
}

function rmlnk() {
  if [ -z "${@:1}" ] ; then
    $SEEHELP
  else
    DIR="$1"
    sudo unlink ${BINDIR}${DIR}
    printf $red "${DIR} Removed" || printf $yellow "Error Removing ${DIR}"
  fi
}

if [ -z "$@" ] ; then
  chklnk
fi

while getopts ":hcmr" option; do
   case $option in
      h|help) Help
         exit 0 ;;
      c|ck|check) chklnk
         exit 0 ;;
      m|mk|make) mklnk
         exit 0 ;;
      r|rm|remove) rmlnk
         exit 0 ;;
   esac
done
