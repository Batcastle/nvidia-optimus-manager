#!/bin/bash

# Automated script to install nvidia-optimus-manager

# VARIABLES
####################################
LDM=/etc/lightdm/lightdm.conf.d    # OLD DIRECTORY - USER CONFIRM
GDM=/etc/gdm
MOD=/etc/modprobe.d
BIN=/usr/bin
OPT=nvidia-optimus-manager
SYSD=nvidia-optimus-autoconfig.service
####################################

# CHECK FOR PRIVS

/usr/bin/clear
builtin echo -e "\n     -------------------------------------------\n\n           NVIDIA-OPTIMUS-MANAGER INSTALLER\n\n     -------------------------------------------\n"
/bin/sleep 3
builtin echo ""
/usr/bin/clear
builtin echo -e "\nThis script will install and autoconfigure\nthe Nvidia-Optimus-Manager for Solus Budgie\nor Gnome editions.\n\nThis WILL require a reboot, once completed.\n"
/bin/sleep 4
/usr/bin/clear

# DESKTOP CHECKS & CONFIGURATION

if [ `builtin echo $XDG_CURRENT_DESKTOP` = "GNOME" ]
then
  builtin echo -e "\nSetting things up for Gnome...\n"
  /bin/sleep 2
  /usr/bin/sudo /bin/cp ${PWD}/99-nvidia.conf ${GDM}/99-nvidia.conf
  /usr/bin/sudo /bin/cp ${PWD}/${OPT} ${BIN}/${OPT}
  /usr/bin/sudo /bin/chmod a+x ${BIN}/${OPT}
  /usr/bin/sudo /bin/cp ${PWD}/${SYSD} /etc/systemd/system/${SYSD}
  builtin echo ""
  /usr/bin/sudo /bin/systemctl daemon-reload && /usr/bin/sudo /bin/systemctl enable nvidia-optimus-autoconfig
  builtin echo ""
    # SYSTEM PREP
    builtin echo -e "\nGetting things ready...\n"
    /usr/bin/sudo /bin/mkdir -p ${MOD}
    builtin echo "blacklist nouveau" | /usr/bin/sudo /usr/bin/tee ${MOD}/blacklist-nouveau.conf
    builtin echo -e "\nInstalling necessary applications...\n"

elif [ `builtin echo $XDG_CURRENT_DESKTOP` = "Budgie:GNOME" ]
then
  builtin echo -e "\nSetting things up for Budgie...\n"
  /bin/sleep 2
  /usr/bin/sudo /bin/cp ${PWD}/99-nvidia.conf ${GDM}/99-nvidia.conf
  /usr/bin/sudo /bin/cp ${PWD}/${OPT} ${BIN}/${OPT}
  /usr/bin/sudo /bin/chmod a+x ${BIN}/${OPT}
  /usr/bin/sudo /bin/cp ${PWD}/${SYSD} /etc/systemd/system/${SYSD}
  builtin echo ""
  /usr/bin/sudo /bin/systemctl daemon-reload && /usr/bin/sudo /bin/systemctl enable nvidia-optimus-autoconfig
  builtin echo ""
    # SYSTEM PREP
    builtin echo -e "\nGetting things ready...\n"
    /usr/bin/sudo /bin/mkdir -p ${MOD}
    builtin echo "blacklist nouveau" | /usr/bin/sudo /usr/bin/tee ${MOD}/blacklist-nouveau.conf
    builtin echo -e "\nInstalling necessary applications...\n"
fi
builtin echo -e "\n               INSTALLATION COMPLETE!\n\n    You will need to reboot to apply all changes.\n\n"

        builtin read -p "              Reboot now (y/n)?" choice
        case "$choice" in 
          y|Y ) /usr/bin/sudo /sbin/reboot;;
          n|N ) builtin echo "Goodbye";;
        esac
        exit
