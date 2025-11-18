#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
dnf group install -y --nobest \
    -x rsyslog* \
    -x cockpit \
    -x cronie* \
    -x crontabs \
    -x PackageKit \
    -x PackageKit-command-not-found \
    "Common NetworkManager submodules" \
    "Core" \
    "Fonts" \
    "Guest Desktop Agents" \
    "Hardware Support" \
    "Printing Client" \
    "Standard" \
    "Workstation product core"

dnf -y install \
    -x PackageKit \
    -x PackageKit-command-not-found \
    -x gnome-software-fedora-langpacks \
    -x gnome-extensions-app \
    -x gnome-software \
    "NetworkManager-adsl" \
    "centos-backgrounds" \
    "gdm" \
    "gnome-bluetooth" \
    "gnome-color-manager" \
    "gnome-control-center" \
    "gnome-initial-setup" \
    "gnome-remote-desktop" \
    "gnome-session-wayland-session" \
    "gnome-settings-daemon" \
    "gnome-shell" \
    "gnome-user-docs" \
    "gvfs-fuse" \
    "gvfs-goa" \
    "gvfs-gphoto2" \
    "gvfs-mtp" \
    "gvfs-smb" \
    "libsane-hpaio" \
    "nautilus" \
    "orca" \
    "ptyxis" \
    "sane-backends-drivers-scanners" \
    "xdg-desktop-portal-gnome" \
    "xdg-user-dirs-gtk" \
    "yelp-tools"

dnf -y install \
    plymouth \
    plymouth-system-theme \
    fwupd \
    systemd-{resolved,container,oomd} \
    libcamera{,-{v4l2,gstreamer,tools}}

systemctl enable gdm

systemctl set-default graphical.target
