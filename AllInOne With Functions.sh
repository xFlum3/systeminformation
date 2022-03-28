#!/bin/bash
#Ver: 1.0

#Echo Colors
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
PINK='\033[1;35m'
WHITE='\033[1;37m'


#Return Button While LOOP
mainmenubackbutton() {
stop="no"
while [ $stop = "no" ]; do
    display_menu;
    read -n 1 -s mainchoices;
	case $mainchoices in
			1) ipconfig;;
			2) tzlang;;
			3) nextcloud;;
            4) systeminfo;;
            5) dockerlist;;
            6) notready;;
            0) clear;echo $'\n'$"Exiting ... Goodbye!";sleep 2;tput cnorm;exit;;
            *) clear;echo "Not a valid choice: Exiting... Goodbye!";sleep 2;tput cnorm;exit;;
	esac
    break
done
}

#First Menu (All In One)
display_menu() {
date=$(date)
cat << _EOF_
$USER@$HOSTNAME
-------------------------------------
Welcome To Alons All-In-One Script,
Choose your option:
    1 - IP-Config
    2 - TimeZone & Language
    3 - Nextcloud Type Checker
    4 - System Information
    5 - Docker List
    6 - Not Ready (Will be LPI Questions Simulator!)
    0 - Exit
    Requested at : $date
-------------------------------------
_EOF_
}


#IP Config Start
ipconfig() {

#IP Config Menu
display_TextIP() {
cat << _EOF_

  *****************************************
  * Linux IP-Config Command Made by AlonD *
  *****************************************
_EOF_
}

ipaddr() {

    ipaddr=$(ip a | grep "inet "| head -n 2 | tail -n 1 | cut -d"/" -f1 | cut -d' ' -f6)
    echo "IP Address: $ipaddr"

    subnet=$(ip a | grep "inet " | head -n 2 | tail -n 1 | cut -d"/" -f2 | cut -d' ' -f1)
    case $subnet in
        23) echo "Subnet Mask: 255.255.254.0";;
        24) echo "Subnet Mask: 255.255.255.0";;
        16) echo "Subnet Mask: 255.255.0.0";;
        8)  echo "Subnet Mask: 255.0.0.0";;
        *)  echo -e "Subnet Mask: ${RED} Not Found! ${NC}";;
    esac    

    default=$(ip route show | head -n 1 | cut -d" " -f3)
    echo "Default Gateway: $default"

    dhcp=$(ip r | head -n 1 | cut -d" " -f3)
    echo "DHCP Server IP: $dhcp"

    dns=$(cat /etc/resolv.conf | grep "nameserver " | head -n 1 |cut -d" " -f2)
    echo "DNS Server: $dns"

    ipv6=$(ip a | grep "inet6 " | head -n 2 | tail -n 1 | cut -d"/" -f1 | cut -d' ' -f6)
    echo "IPV6: $ipv6"

    wired=$(ip a | grep "2: " | cut -d":" -f2 | cut -d" " -f2)
    echo "Wired Interface: $wired"
    echo
    echo "Press 9 To Return Main Menu \ Any Other Key To Exit"
}

clear
tput civis # Hide cursor
display_TextIP
ipaddr

read -n 1 -s choice;
    case $choice in
    9) mainmenubackbutton;;
    *) clear;echo $'\n'$"Exiting ...";sleep 2;tput cnorm;exit;;
    esac
tput cnorm
}
#IP Config End

#TimeZone & Language
tzlang() {
tz=$(timedatectl | grep "Time " | cut -d":" -f2)
lang=$(locale | head -n 1 | cut -d"=" -f2 | cut -d"." -f1)
    echo "Time Zone:$tz"
    echo "Language: $lang"
    echo "Press 9 To Return Main Menu \ Any Other Key To Exit"

read -n 1 -s choice;
    case $choice in
    9) mainmenubackbutton;;
    *) clear;echo $'\n'$"Exiting ...";sleep 2;tput cnorm;exit;;
    esac
}

#NextCloud Start
nextcloud() {

#NextCloud Menu 
display_menuNext() {
cat << _EOF_

 ==================================================
 = Linux NextCloud Installed Checker Made by AlonD =
 ==================================================

 Choose the option you want:
    1. Apache2
    2. Snap
    9. Return To Main Menu
    0. Exit
_EOF_
}

snapd() {
snapinstalled=$(snap list 2>/dev/null | grep -i "next" | cut -d" " -f1)
case $snapinstalled in
    nextcloud)
     snapv=$(snap list | grep -i "next" | cut -d" " -f3)
     snaptrack=$(snap list | grep -i "next" | cut -d" " -f8)
        echo -e "${BLUE} NextCloud ${NC}: Installed ${GREEN}✓ ${NC}"
        echo -e "${BLUE} Version ${NC}: $snapv"
        echo -e "${BLUE} Tracking ${NC}: $snaptrack"
    ;;
    *) echo -e "${RED} NextCloud Not Installed By Snap! ${NC} (snap install nextcloud for installation) or check apache2 option."
esac
}

apache2() {
apache2check=$(find /var/www/ -name nextcloud 2>/dev/null)
case $apache2check in
    *)
    echo -e "${RED} NextCloud Not Installed By Apache2! ${NC}"
    ;;
    nextcloud) echo -e "${BLUE} NextCloud ${NC}: Installed ${GREEN}✓ ${NC}"
esac
}
clear
tput civis # Hide cursor
display_menuNext

#NextCloud Options (Answers)
read -n 1 -s choice;
    case $choice in
        1) apache2;;
        2) snapd;;
        9) mainmenubackbutton;;
        0) clear;echo $'\n'$"Exiting...";sleep 2;tput cnorm; exit;;
        *) clear;echo "Not a vaild choise: Exiting...";sleep 2;tput cnorm;exit;;
    esac
tput cnorm
}
#NextCloud END

#System Information Start
systeminfo() {

#SystemInfo Menu 
display_menuSysinfo() {
    echo -e "${PURPLE}=================================================================="
    echo -e "=  System Information Supports Only Ubuntu & Debian & Raspbian & Kali ="
    echo -e "=================================================================== ${NC}"
#Logos Display (Waste of time !!!!)
os_type=$(hostnamectl | grep "Operating" | cut -d":" -f2 | cut -d" " -f2)
    case $os_type in
        Debian)
          echo -e "${RED}
            _____
           /  __ \\
          |  /    |
          |  \\___-
          -_
            --_
                ${NC}"
        ;;
        Ubuntu)
            echo -e "${WHITE}
                ---(_)
             _/  ---  \\
            (_) |   |
              \\  --- _/
                 ---(_)
                    ${NC}"
        ;;
        Raspbian)
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
        ;;
        Kali)
        echo -e "${BLUE}
        ..............
            ..,;:ccc,.
          ......''';lxO.
.....''''..........,:ld;
           .';;;:::;,,.x,
      ..'''.            0Xxoc:,.  ...
  ....                ,ONkc;,;cokOdc',.
 .                   OMo           ':ddo.
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
        ;;
        Arch)
        echo -e "${BLUE}
             ooo
            ooooo
           ooooooo
          ooooooooo
         ooooo ooooo
        ooooo   ooooo
       ooooo     ooooo
      ooooo      ooooo
     ooooo       ooooo
    ooooo        oooo
        ${NC}"
        ;;
        *)
        echo "Cannot Found OS Logo (Maybe not supported!)"
    esac
}

osinfo() {
    os=$(hostnamectl | grep "Operating" | cut -d":" -f2)
    architecture=$(hostnamectl | grep "Archite" | cut -d":" -f2 | cut -d" " -f2)
        echo -e "${RED} OS ${NC}: $os $architecture"
}

host() {

dmicheck=$(sudo dmidecode 2>/dev/null | wc -l)

while [ $dmicheck -gt 0 ]; do
    case $os_type in
        Raspbian)
            host=$(cat /proc/cpuinfo | grep "Model" | cut -d":" -f2)
	        echo -e "${RED} Host ${NC}: $host"
        ;;
        Arch)
            host=$(sudo dmidecode -t 2 | grep  -i "Product" | cut -d":" -f2 | cut -d" " -f2)
            version=$(sudo dmidecode -t 2 | grep -i "Version" | cut -d":" -f2 | cut -d" " -f2)
            echo -e "${RED} Host ${NC}: $host , $version"
        ;;
        *)
        	host=$(sudo dmidecode | grep "Product" | head -n 1 | cut -d":" -f2)
	        version=$(sudo dmidecode | grep -A3 '^System Information' | grep "Version:" | cut -d":" -f2)
	        echo -e "${RED} Host ${NC}: $host , $version"
        ;;
    esac
    break
done

while [ $dmicheck = 0 ]; do
    case $os_type in
        *) 
            echo -e "${RED} ================================================= ${NC}"
            echo -e "${RED} Host ${NC}: dmidecode not installed!"
            echo -e "${BLUE} Apt ${NC}: sudo apt install dmidecode"
            echo -e "${BLUE} Pacman ${NC}: sudo pacman -Sy dmidecode"
            echo -e "${RED} ================================================= ${NC}"
        ;;
    esac
    break
done

}

kernel() {
    kernelv=$(uname -r)
    echo -e "${RED} Kernel ${NC}: $kernelv"
}

timer() {
    serverruntime=$(uptime -p | cut -d"," -f2-7)
    echo -e "${RED} Uptime ${NC}: $serverruntime"
}

packages() {
dpkg=$(dpkg --list 2>/dev/null | wc -l)
snap=$(snap list 2>/dev/null | wc -l)
apt=$(apt list 2>/dev/null | wc -l)
pacman=$(pacman -Qe 2>/dev/null | wc -l)

case $os_type in
    Arch) echo -e "${RED} Pakcages ${NC}: $pacman (pacman)"
    ;;
    Ubuntu) echo -e "${RED} Pakcages ${NC}: $dpkg (dpkg), $snap (snap), $apt (apt)"
    ;;
    Debian) echo -e "${RED} Pakcages ${NC}: $dpkg (dpkg), $snap (snap), $apt (apt)"
    ;;
    Kali) echo -e "${RED} Pakcages ${NC}: $dpkg (dpkg), $snap (snap), $apt (apt)"
    ;;
    Raspbian) echo -e "${RED} Pakcages ${NC}: $dpkg (dpkg), $snap (snap), $apt (apt)"
    ;;
    *) echo -e "${RED} Pakcages ${NC}: Err! Not Installed or Not Supported yet!"
esac

}

shelloptions() {
shell=$(bash --version | grep "version" | cut -d" " -f4 | head -n1 | cut -d"(" -f1)
type=$(echo "$SHELL" | cut -d"/" -f3)

case $os_type in
    Ubuntu | Debian | Kali | Raspbian | Arch) echo -e "${RED} Shell ${NC}: $type $shell"
    ;;
    *) echo -e "${RED} Shell ${NC}: Not Found \ Not Supported!"
esac

}

desktopenv() {
deoptions() {
de=$(echo $XDG_CURRENT_DESKTOP | cut -d":" -f2)
i3=$(i3 --version 2>/dev/null)

    case $deoptions in
        XFCE)
       	    version=$(xfce4-session --version | head -n 1 | cut -d" " -f2)
	        echo -e "${RED} DE ${NC}: $de $version"
        ;;
        GNOME)
            version=$(gnome-shell --version | cut -d" " -f3)
	        echo -e "${RED} DE ${NC}: $de $version"
        ;;
        i3) 
            version=$(i3 --version | cut -d" " -f3)
            echo -e "${RED} DE ${NC}: $i3 , $version"
        *) echo -e "${RED} DE ${NC}: Not Exist! \ Not Supported!"
    esac
    }
}

windowsmanager() {
case $de in
    GNOME) echo -e "${RED} WM ${NC}: Mutter"
    ;;
    XFCE) echo -e "${RED} WM ${NC}: xfwm4"
    ;;
    *) return
esac

}

resoultion() {
xorg=$(dpkg -l 2>/dev/null | grep -i xserver-xorg-core | cut -d" " -f3 | wc -l)
if test $xorg -gt 0; then
    res=$(xdpyinfo | grep dimensions | cut -d":" -f2 | cut -d"(" -f1 | cut -d" " -f5-6)
    echo -e "${RED} Resolution ${NC}: $res"
elif test $os_type = "Arch"; then
    xrandr=$(xrandr | grep -i "current" | cut -d"," -f2 | cut -d" " -f3-5)
    echo -e "${RED} Resolution ${NC}: $xrandr"
elif test $xorg = "0"; then
    return;
else
    echo -e "${RED} Resolution ${NC}: Not Exist \ Not Supported!"
fi
}

cpu() {
    cpudisplay=$(cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -d":" -f2)
    echo -e "${RED} CPU ${NC}: $cpudisplay"
}

gpu() {
gpu=$(lspci | grep VGA | cut -d" " -f5-8)
case $os_type in
    Ubuntu) echo -e "${RED} GPU ${NC}: $gpu"
    ;;
    Debian) echo -e "${RED} GPU ${NC}: $gpu"
    ;;
    Kali) echo -e "${RED} GPU ${NC}: $gpu"
    ;;
    Raspbian) return
    ;;
    Arch) echo -e "${RED} GPU ${NC}: $gpu"
    ;;
    *) echo -e "${RED} GPU ${NC}: Err! Maybe not supported!"
esac
}

ram() {
    memoryused=$(free -m | grep "Mem" | awk '{print $3}')
    memorytotal=$(free -m | grep "Mem" | awk '{print $2}')
    echo -e "${RED} Memory ${NC}: $memoryused MB / $memorytotal MB"
}

#Will Be Menu Soon!
display_menuSysinfo
osinfo
host
kernel
timer
packages
shelloptions
desktopenv
windowsmanager
resoultion
cpu
gpu
ram
}
#System Information End

#Docker Lister Start
dockerlist() {
cat << _EOF_

 =====================================
 = Linux Docker Lister Made by AlonD =
 =====================================

 Do you want to watch your dockers?
    1. Yes
    2. No
    0. Exit
_EOF_

rundockerlist() {
dockerps=$(docker ps 2>/dev/null)
dockercheck=$(docker ps 2>/dev/null | wc -l)
if test $dockercheck = "0"; then
    echo -e "${BLUE} Docker List: ${RED} Not Found! ${NC}"
    echo -e "${WHITE} Check if you have installed docker.io if not : apt install docker.io  ${NC}"
else
cat << _EOF_
$dockerps
_EOF_
fi
}

read -n 1 -s choice;
    case $choice in
    1) rundockerlist;;
    2) mainmenubackbutton;;
    0) clear;echo $'\n'$"Exiting ... Goodbye!";sleep 2;tput cnorm;exit;;
    *) clear;echo "Not a valid choice: Exiting... Goodbye!";sleep 2;tput cnorm;exit;;
    esac
} #Docker Lister End

#First Menu Answers (Options)
clear
tput civis # Hide cursor
display_menu

read -n 1 -s mainchoices;
	case $mainchoices in
			1) ipconfig;;
			2) tzlang;;
			3) nextcloud;;
            4) systeminfo;;
            5) dockerlist;;
            6) notready;;
            0) clear;echo $'\n'$"Exiting ... Goodbye!";sleep 2;tput cnorm;exit;;
            *) clear;echo "Not a valid choice: Exiting... Goodbye!";sleep 2;tput cnorm;exit;;
	esac
tput cnorm