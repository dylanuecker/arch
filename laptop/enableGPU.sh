#!/bin/sh
# from https://wiki.archlinux.org/title/Dell_XPS_15_(9570)

# check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "$0 is not running as root. Try using sudo."
    exit 2
fi
# allow to load nvidia module
if [ ! -f /etc/modprobe.d/disable-nvidia.conf ]; then
	printf "File /etc/modprobe.d/disable-nvidia.conf does not exist.\n"
	printf "Is the GPU already enabled ?\n"
	exit 1
fi
printf "Allowing to load NVIDIA modules...\n"
mv /etc/modprobe.d/disable-nvidia.conf /etc/modprobe.d/disable-nvidia.conf.disable
printf "Changing power control...\n"
# remove NVIDIA card (currently in power/control = auto)
echo -n 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
sleep 1
# change PCIe power control
echo -n on > /sys/bus/pci/devices/0000\:00\:01.0/power/control
sleep 1
# rescan for NVIDIA card (defaults to power/control = on)
printf "Rescaning....."
echo -n 1 > /sys/bus/pci/rescan
if [ -x "$(command -v nvidia-smi)" ]; then
	printf "\n"
	nvidia-smi
fi
printf "\nNVIDIA CARD IS NOW ENABLED.\n"
