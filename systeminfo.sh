#!/bin/bash

#Echo Colors
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'

echo -e "${PURPLE}==================================================="
echo -e "=  System Information Supports Only Ubuntu&Debian ="
echo -e "=================================================== ${NC}"

echo -e "${RED} $USER@$HOSTNAME"
echo -e "${NC} -------------------------"

os=$(hostnamectl | grep "Operating" | cut -d":" -f2)
architecture=$(hostnamectl | grep "Archite" | cut -d":" -f2 | cut -d" " -f2)
echo -e "${RED} OS ${NC}: $os $architecture"

host=$(sudo dmidecode | grep "Product" | head -n 1 | cut -d":" -f2)
version=$(sudo dmidecode | grep -A3 '^System Information' | grep "Version:" | cut -d":" -f2)
echo -e "${RED} Host ${NC}: $host $version"

kernel=$(uname -r)
echo -e "${RED} Kernel ${NC}: $kernel"

uptime=$(uptime -p | cut -d" " -f2-7)
echo -e "${RED} Uptime ${NC}: $uptime"

dpkg=$(dpkg --list | wc -l)
snap=$(snap list | wc -l)
if test $dpkg != $dpkg; then
	echo "0 (dpkg), "
elif test $snap != $snap; then
	echo "0 (snap)"
else
	echo -e "${RED} Packages ${NC}: $dpkg (dpkg), $snap (snap)"
fi

shell=$(bash --version | grep "version" | cut -d" " -f4 | head -n1 | cut -d"(" -f1)
type=$(echo "$SHELL" | cut -d"/" -f3)
echo -e "${RED} Shell ${NC}: $type $shell"

res=$(xdpyinfo | grep dimensions | cut -d":" -f2 | cut -d"(" -f1 | cut -d" " -f5-6)
echo -e "${RED} Resolution ${NC}: $res"

cpu=$(cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -d":" -f2)
echo -e "${RED} CPU ${NC}: $cpu"

gpu=$(lspci | grep VGA | cut -d" " -f5-8)
echo -e "${RED} GPU ${NC}: $gpu"

memoryused=$(free -m | grep "Mem:" | cut -d":" -f2 | cut -d" " -f12)
memoryfree=$(free -m | grep "Mem:" | cut -d":" -f2 | cut -d" " -f20)
echo -e "${RED} Memory ${NC}: $memoryfree MB / $memoryused MB"

exit 0