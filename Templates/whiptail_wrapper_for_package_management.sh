#!/usr/bin/env bash

function aptModule() {
{
INC="$( echo $((100/"$(echo $LIST | wc | awk '{print $2}')")))"
for PKG in $LIST ; do
    sleep 0.5
    COMMAND="apt ${ACTION} ${PKG} -y"
    echo -e "XXX\n${PER}\n${COMMAND}... \nXXX"
    $COMMAND 2> /dev/null
    PER=$(( $PER + $INC ))
    echo -e "XXX\n${PER}\n${COMMAND}... Done.\nXXX"
    sleep 0.5
done
} | whiptail --title "Apt ${ACTION}" --gauge "Please wait while ${ACTION}ing" 6 60 0
result="Successfully ${ACTION}ed the following:\n$LIST"
}

while [ 1 ]
do
CHOICE=$(
whiptail --title "Operative Systems" --menu "Make your choice" 16 100 9 \
        "1)" "Install"   \
        "2)" "Purge"  3>&2 2>&1 1>&3
)

case $CHOICE in
        "1)")
                LIST="x11-apps mc"
                ACTION="install"
                aptModule
                read -r result < result
        ;;

        "2)")
                LIST="x11-apps mc"
                ACTION="purge"
                aptModule
                read -r result < result
        ;;
esac
whiptail --msgbox "$result" 20 78
if [ $? = 1 ]; then
  :
else
  break
fi
done
exit
