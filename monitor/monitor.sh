#!/bin/bash
while getopts ivh opt
do
	case $opt in
		i)iopt=1;;
		v)vopt=1;;
		h)hopt=1;;
		*)echo "Invalid arg";;
	esac
done

if [[ ! -z $iopt  ]];then
	{
	wd=$(pwd)
	basename "$(test -L "$0" && readlink "$0" || echo "$0")" >/tmp/scriptname
	scriptname=$(echo -e -n $wd/ && cat /tmp/scriptname)
	su -c "cp $scriptname /usr/bin/monitor " root && echo "Congratulations! Script Installed, now run monitor Command" || echo "Error!Installation Failed!"
	}
fi

if [[ ! -z $vopt  ]];then
	{
		echo -e "version 1.0;Designed By Atao"
	}
fi

if [[ ! -z $hopt  ]];then
	{
		echo -e " -i Install script"
		echo -e " -v Print Version Information"
		echo -e " -h Print Help Information"
	}
fi

if [[ $# -eq 0 ]];then
	{
		clear
		unset mine os architecture kernelrelease internalip nameserver loadaverage
		# Define Variable 
		mine=$(tput sgr0)
		# Check if connected to Internet or not
		ping -c 1 www.baidu.com &> /dev/null && echo -e '\E[32m'"Internet: $mine Connected" || echo -e '\E[32m'"Internet: $mine Disconnected"
		# Check OS Type
		os=$(uname -o)
		echo -e '\E[32m'"Operation System Type: "$mine $os
		# 判断：Check OS Release Version and Name
		##################################
		OS=`uname -s`
		REV=`uname -r`
		MACH=`uname -m`
		GetVersionFromFile(){
			VERSION=`cat &1 | tr "\n" ' ' | sed s/.*VERSION.*=\ //`
		}
		if [ "${OS}" = "SunOS" ];then
			OS=Solaris
			ARCH=`uname -p`
			OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
		elif [ "${OS}" = "AIX" ];then
			OSSTR="${OS} `oslevel` (`oslevel -r `)"
		elif [ "${OS}" = "Linux" ];then
			KERNEL='uname -r'
			if [ -f /etc/redhat-release ];then
				DIST='RedHat'
				PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
				REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/debian_version ];then
				DIST="Debian `cat /etc/debian_version`"
				REV=""
			fi
			if ${OSSTR} [ -f /etc/UnitedLinux-release ]; then
				DIST="${OS} ${DIST}(${PSUSEDONAME} ${KENEL} ${MACH})"
			fi
			OSSTR="${OS} ${DIST} ${REV} (${PSUSEDONAME} ${KERNEL} ${MACH})"
		fi
		# 将判断的结果进行输出
		###########################
		echo -e '\E[32m'"OS Version :" $mine $OSSTR
		architecture=$(uname -m)
		echo -e '\E[32m'"Architechture :" $mine $architecture
		kernelrelease=$(uname -r)
		echo -e '\E[32m'"Kernel Release :" $mine $kernelrelese
		interalip=$(hostname -I)
		echo -e '\E[32m'"Internal IP :" $mine $internalip
		free -h | grep -v + >/tmp/ramcache
		echo -e '\E[32m'"Ram Usages :" $mine
		cat /tmp/ramcache | grep -v "Swap"
		echo -e '\E[32m'"Swap Usages :" $mine
		cat /tmp/ramcache | grep -v "Mem"
		
		df -h | grep 'Filesystem\|/dev/sda*' > /tmp/diskusage

		echo -e '\E[32m'"Disk Usages :" $mine
		cat /tmp/diskusage

		loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
		echo -e '\E[32m'"LoadAverage :" $mine $loadaverage
		tecuptime=$(uptime | awk '{print $3,$4 }'| cut -f1 -d,)
		echo -e '\E[32m'"System Uptime Days/(HH:MM) :" $mine $tecuptime

		unset mine os architecture kernelrelease internalip loadaverage

		rm /tmp/ramcache /tmp/diskusage
	}
fi


# shift命令来左移参数
shift $(($OPTIND -1))
