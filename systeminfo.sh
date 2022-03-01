#!/bin/bash

#Echo Colors
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
PINK='\033[1;35m'
WHITE='\033[1;37m'

echo -e "${PURPLE}================================================================"
echo -e "=  System Information Supports Only Ubuntu & Debian & Raspbian ="
echo -e "================================================================ ${NC}"

#Logos Display (Waste of time !!!!)
os_type=$(hostnamectl | grep "Operating" | cut -d":" -f2 | cut -d" " -f2)

if test $os_type = "Debian"; then
  echo -e "${RED}
  _____
 /  __ \\
|  /    |
|  \\___-
-_
  --_
  ${NC}"
elif test $os_type = "Ubuntu"; then
  echo -e "${WHITE}
    ---(_)
 _/  ---  \\
(_) |   |
  \\  --- _/
     ---(_)
  ${NC}"
elif test $os_type = "Raspbian"; then
	echo -e "${PINK}
   ..    ,.
  :oo: .:oo:
  'o\\o o/o:
 :: . :: . ::
:: :::  ::: ::
:'  '',.''  ':
 ::: :::: :::
 ':,  ''  ,:'
   ' ~::~ '
${NC}"
elif test $os_type = "Kali"; then
	echo -e "${BLUE}
	 ..............
            ..,;:ccc,.
          ......''';lxO.
.....''''..........,:ld;
           .';;;:::;,,.x,
      ..'''.            0Xxoc:,.  ...
  ....                ,ONkc;,;cokOdc',.
 .                   OMo           ':${c2}dd${c1}o.
                    dMc               :OO;
                    0M.                 .:o.
                    ;Wd
                     ;XO,
                       ,d0Odlc;,..
                           ..',;:cdOOd::,.
                                    .:d;.':;.
                                       'd,  .'
                                         ;l   ..
                                          .o
                                            c
                                            .'
                                             .
${NC}"
else
  echo "Cannot Found OS Type."
fi

#User & hostname display
echo -e "${RED} $USER@$HOSTNAME"
echo -e "${BLUE}-------------------------${NC}"

#OS
os=$(hostnamectl | grep "Operating" | cut -d":" -f2)
architecture=$(hostnamectl | grep "Archite" | cut -d":" -f2 | cut -d" " -f2)
echo -e "${RED} OS ${NC}: $os $architecture"

#Desktop Environment
de=$(echo $XDG_CURRENT_DESKTOP | cut -d":" -f2)

if test $de != $de; then
	echo -e "${RED} DE ${NC}: Not Exist!"
elif test $de = "XFCE"; then
	version=$(xfce4-session --version | head -n 1 | cut -d" " -f2)
	echo -e "${RED} DE ${NC}: $de $version"
elif test $de = "GNOME"; then
	version=$(gnome-shell --version | cut -d" " -f3)
	echo -e "${RED} DE ${NC}: $de $version"
fi

#Host
if test $USER = "root"; then
	host=$(dmidecode | grep "Product" | head -n 1 | cut -d":" -f2)
	version=$(dmidecode | grep -A3 '^System Information' | grep "Version:" | cut -d":" -f2)
	echo -e "${RED} Host ${NC}: $host $version"
elif test $os_type = "Raspbian"; then
	host=$(cat /proc/cpuinfo | grep "Model" | cut -d":" -f2)
	echo -e "${RED} Host ${NC}: $host"
else
	host=$(sudo dmidecode | grep "Product" | head -n 1 | cut -d":" -f2)
	version=$(sudo dmidecode | grep -A3 '^System Information' | grep "Version:" | cut -d":" -f2)
	echo -e "${RED} Host ${NC}: $host $version"
fi

#Kernel
kernel=$(uname -r)
echo -e "${RED} Kernel ${NC}: $kernel"

#UPTime
uptime=$(uptime -p | cut -d" " -f2-7)
echo -e "${RED} Uptime ${NC}: $uptime"

#Packages (!Not Finished!)
dpkg=$(dpkg --list | wc -l)
#snap=$(snap list | wc -l)
if test $dpkg != $dpkg; then
	echo "0 (dpkg), "
#elif test $snap != $snap; then
#	echo "0 (snap)"
else
	#echo -e "${RED} Packages ${NC}: $dpkg (dpkg), $snap (snap)"
	echo -e "${RED} Packages ${NC}: $dpkg (dpkg)"
fi

#Shell
if test $os_type = "Ubuntu"; then
	shell=$(bash --version | grep "version" | cut -d" " -f4 | head -n1 | cut -d"(" -f1)
	type=$(echo "$SHELL" | cut -d"/" -f3)
	echo -e "${RED} Shell ${NC}: $type $shell"
elif test $os_type = "Debian"; then
	shell=$(bash --version | grep "version" | cut -d" " -f4 | head -n1 | cut -d"(" -f1)
	type=$(echo "$SHELL" | cut -d"/" -f3)
	echo -e "${RED} Shell ${NC}: $type $shell"
elif test $os_type = "Raspbian"; then
	shell=$(bash --version | grep "version" | cut -d" " -f4 | head -n1 | cut -d"(" -f1)
	type=$(echo "$SHELL" | cut -d"/" -f3)
	echo -e "${RED} Shell ${NC}: $type $shell"
elif test $os_type = "Kali"; then
	shell=$(bash --version | grep "version" | cut -d" " -f4 | head -n1 | cut -d"(" -f1)
	type=$(echo "$SHELL" | cut -d"/" -f4)
	echo -e "${RED} Shell ${NC}: $type $shell"
fi

#Resolution (Cannot Support RaspberrPI)
if test $os_type = "Ubuntu"; then
	res=$(xdpyinfo | grep dimensions | cut -d":" -f2 | cut -d"(" -f1 | cut -d" " -f5-6)
	echo -e "${RED} Resolution ${NC}: $res"
elif test $os_type = "Debian"; then
	res=$(xdpyinfo | grep dimensions | cut -d":" -f2 | cut -d"(" -f1 | cut -d" " -f5-6)
	echo -e "${RED} Resolution ${NC}: $res"
elif test $os_type = "Kali"; then
	res=$(xdpyinfo | grep dimensions | cut -d":" -f2 | cut -d"(" -f1 | cut -d" " -f5-6)
	echo -e "${RED} Resolution ${NC}: $res"
fi

#CPU
cpu=$(cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -d":" -f2)
echo -e "${RED} CPU ${NC}: $cpu"

#GPU (Cannot Support RaspberrPI)
if test $os_type = "Ubuntu"; then
	gpu=$(lspci | grep VGA | cut -d" " -f5-8)
	echo -e "${RED} GPU ${NC}: $gpu"
elif test $os_type = "Debian"; then
	gpu=$(lspci | grep VGA | cut -d" " -f5-8)
	echo -e "${RED} GPU ${NC}: $gpu"
elif test $os_type = "Kali"; then
	gpu=$(lspci | grep VGA | cut -d" " -f5-8)
	echo -e "${RED} GPU ${NC}: $gpu"
fi

#RAM
memoryused=$(free -m | grep "Mem" | awk '{print $3}')
memorytotal=$(free -m | grep "Mem" | awk '{print $2}')
echo -e "${RED} Memory ${NC}: $memoryused MB / $memorytotal MB"

exit 0
