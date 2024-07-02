#!/usr/bin/env bash

function oneToOneHundred {
    for ((i=0; i<=60; i+=1)) ; do
        sleep 0.1
        echo $i
    done | whiptail --backtitle "PROGRESS GAUGE" --title "Calculating Result" --gauge "Please wait for calculation" 8 50 0
result="success"
}

function aptModule {
{
    sleep 0.5
    echo -e "XXX\n0\napt remove package_0... \nXXX"
    ## command here
    echo -e "XXX\n25\napt remove package_0... Done.\nXXX"
    sleep 0.5

    echo -e "XXX\n25\napt remove package_1... \nXXX"
    ## command here
    echo -e "XXX\n50\napt remove package_1... Done.\nXXX"
    sleep 0.5

    echo -e "XXX\n50\napt remove package_2... \nXXX"
    ## command here
    echo -e "XXX\n75\napt remove package_2... Done.\nXXX"
    sleep 0.5

    echo -e "XXX\n75\napt remove package_3... \nXXX"
    ## command here
    echo -e "XXX\n100\napt remove package_3... Done.\nXXX"
    sleep 1
} |whiptail --title "Apt Removal" --gauge "Please wait while installing" 6 60 0
result="success"
}

while [ 1 ]
do
CHOICE=$(
whiptail --title "Operative Systems" --menu "Make your choice" 16 100 9 \
        "1)" "Demo 1-100"   \
        "2)" "Demo process gauge"  3>&2 2>&1 1>&3
)

case $CHOICE in
        "1)")
                oneToOneHundred
                read -r result < result
        ;;

        "2)")
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
