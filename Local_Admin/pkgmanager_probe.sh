#!/usr/bin/env sh

## A function to determine package manager then update && upgrade
#

function pkgmgr_id() {
# List possible package managers
for PKGMGR in apt yum apk dnf emerge zypper pacman; do
        test "$(command -v $PKGMGR)"
done

# Assign the correct update sequence
case $PKGMGR in
        apt) UPDATE="update && sudo $PKGMGR upgrade -y";;
        yum) UPDATE="update";;
        apk) UPDATE="upgrade --no-cache";;
        dnf) UPDATE="upgrade";;
        emerge) UPDATE="--sync && $PKGMGR -[a]uDN @world";;
        zypper) UPDATE="refresh && $PKGMGR up";;
        pacman) UPDATE="-Scc --noconfirm && sudo $PKGMGR -Syyu --noconfirm";;
esac

# Create the full command
ACTION=$PKGMGR $UPDATE
echo "Do you wish to update?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo $ACTION; break;;
        No ) exit;;
        *) echo "Please select an option."
    esac
done
}

pkgmgr_id
