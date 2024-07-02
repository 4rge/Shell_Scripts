#!/usr/bin/env/ bash

Help() {
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}

GPL() {
   echo "GPL License here"
}

Verbose() {
   echo "This should exit 0"
}

Version() {
   echo "This should exit 1"
}

if [ -z "$@" ] ; then
  echo "Needs args"
fi

while getopts ":hgvV" option; do
   case $option in
      h) Help
         exit ;;
      g) GPL
         exit ;;
      v) Verbose
         exit 0 ;;
      V) Version
         exit 1 ;;
   esac
done
