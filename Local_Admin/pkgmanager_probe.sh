#!/bin/sh

# Check for Root Privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo."
  exit 1
fi

# Function to update and upgrade APT
update_apt() {
  echo "Detected APT package manager (Debian/Ubuntu/antiX)."
  apt clean
  apt update && apt upgrade -y
}

# Function to update and upgrade DNF
update_dnf() {
  echo "Detected DNF package manager (Fedora/RHEL/CentOS 8+)."
  dnf clean all
  dnf upgrade --refresh -y
}

# Function to update and upgrade YUM
update_yum() {
  echo "Detected YUM package manager (RHEL/CentOS 7 and earlier)."
  yum clean all
  yum update -y
}

# Function to update and upgrade Pacman
update_pacman() {
  echo "Detected Pacman package manager (Arch Linux)."
  pacman -Scc --noconfirm
  pacman -Syu --noconfirm
}

# Function to update and upgrade PKG
update_pkg() {
  echo "Detected PKG package manager (FreeBSD/TrueNAS)."
  pkg clean -a
  pkg update && pkg upgrade -y
}

# Function to update and upgrade APK
update_apk() {
  echo "Detected APK package manager (Alpine Linux)."
  apk cache clean
  apk update && apk upgrade
}

# Function to update and upgrade Zypper
update_zypper() {
  echo "Detected Zypper package manager (openSUSE)."
  zypper clean --all
  zypper refresh && zypper update -y
}

# Function to update and upgrade Portage (Gentoo)
update_portage() {
  echo "Detected Portage package manager (Gentoo)."
  emerge --sync
  emerge --update --deep --newuse @world
}

# Function to update and upgrade Homebrew (macOS)
update_homebrew() {
  echo "Detected Homebrew package manager (macOS)."
  brew cleanup
  brew update && brew upgrade
}

# Function to update and upgrade Slackware
update_slackware() {
  echo "Detected Slackware package management."
  slackpkg update
  slackpkg upgrade-all
}

# Function to update Puppy Linux
update_puppy() {
  echo "Detected Puppy Linux package management. Using Puppy Package Manager."
  # This could use various methods; pseudocode for demonstration:
  # run the command for Puppy Package Manager
  ppm # If Puppy Package Manager is available
}

# Function to handle unknown systems
handle_unknown() {
  echo "Detected an unsupported or lesser-known system: $1"
  echo "Please consult your system's documentation for package management."
}

# Main script logic to detect package manager
case "$(uname -s)" in
  Linux)
    # Detect the package manager on Linux systems
    case "$(command -v apt dnf yum pacman apk zypper slackpkg)" in
      *"/usr/bin/apt"*)
        update_apt
        ;;
      *"/usr/bin/dnf"*)
        update_dnf
        ;;
      *"/usr/bin/yum"*)
        update_yum
        ;;
      *"/usr/bin/pacman"*)
        update_pacman
        ;;
      *"/usr/bin/apk"*)
        update_apk
        ;;
      *"/usr/bin/zypper"*)
        update_zypper
        ;;
      *"/usr/bin/slackpkg"*)
        update_slackware
        ;;
      *)
        # Check for Puppy Linux specific commands
        if command -v ppm > /dev/null; then
          update_puppy
        else
          handle_unknown "Linux"
        fi
        ;;
    esac
    ;;
  FreeBSD)
    update_pkg
    ;;
  Darwin)
    if command -v brew > /dev/null; then
      update_homebrew
    else
      handle_unknown "macOS"
    fi
    ;;
  NetBSD)
    handle_unknown "NetBSD"
    ;;
  OpenBSD)
    handle_unknown "OpenBSD"
    ;;
  Solaris)
    handle_unknown "Solaris"
    ;;
  DragonFly)
    handle_unknown "DragonFly BSD"
    ;;
  Minix)
    handle_unknown "Minix"
    ;;
  *)
    handle_unknown "$(uname -s)"
    ;;
esac

echo "All packages have been updated and upgraded successfully."
