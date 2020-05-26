#!/bin/bash

##脚本功能##
# 1.支持远程多台服务器-部署
#   1.1 更新yum源
#   1.2 部署docker和docker-compose
#   1.2 部署LNMP/LAMP
#      1.2.1 支持单独安装Nginx/Apache/Mysql/PHP
#      1.2.2 支持一键安装LNMP/LAMP
#      1.2.3 支持
#   1.3 部署python/java/golang/nodejs
#   1.4 部署
# 2.支持远程多台服务器-操作
#   1.1 执行本地脚本
#   1.2 传输文件
#   1.3 查看指定路径日志
#   1.4 分析服务器性能
#   1.5 查看Nginx日志

function menu(){
cat << EOF
--------------------------------------------------
|******** Please Enter Your Choice:[1-4] ********|
--------------------------------------------------
* `echo -e "\033[35m 1)lamp install\033[0m"`
* `echo -e "\033[35m 2)lnmp install\033[0m"`
* `echo -e "\033[35m 3)quit\033[0m"`
EOF
}

function lamp_menu(){
cat << EOF
--------------------------------------------------
|******** Please Enter Your Choice:[1-5] ********|
--------------------------------------------------
* `echo -e "\033[35m 1)apache install\033[0m"`
* `echo -e "\033[35m 2)mysql install\033[0m"`
* `echo -e "\033[35m 3)php install\033[0m"`
* `echo -e "\033[35m 4)return main menu\033[0m"`
EOF

read -p "####please input second_lamp options[1-4]:" num2
expr $num2 +1 &>/dev/null # 判断输入是否为整数
if [ $? -ne 0  ];then
	echo "####################################"
	echo "Error Input!Please enter choose[1-4]"
	echo "####################################"
	exit 1
fi
case $num2 in
	1)
		echo "Installed Apache"
		lamp_menu
		;;

	2)
		echo "Installed Mysql"
		lamp_menu
		;;
	3)
		echo "Installed PHP"
		lamp_menu
		;;
	4)
		clear
		menu
		;;
	*)
		clear
		echo -e "\033[31mYour Enter Error! Please input Choice:[1-4]\033[0m"
		lamp_menu
esac
}


function lnmp_menu(){
cat << EOF
--------------------------------------------------
|******** Please Enter Your Choice:[1-5] ********|
--------------------------------------------------
* `echo -e "\033[35m 1)nginx install\033[0m"`
* `echo -e "\033[35m 2)mysql install\033[0m"`
* `echo -e "\033[35m 3)php install\033[0m"`
* `echo -e "\033[35m 4)return main menu\033[0m"`
EOF

read -p "####please input second_lnmp options[1-4]:" num3
expr $num3 +1 &>/dev/null # 判断输入是否为整数
if [ $? -ne 0  ];then
	echo "####################################"
	echo "Error Input!Please enter choose[1-4]"
	echo "####################################"
	exit 1
fi
case $num3 in
	1)
		echo "Installed Nginx"
		lnmp_menu
		;;

	2)
		echo "Installed Mysql"
		lnmp_menu
		;;
	3)
		echo "Installed PHP"
		lnmp_menu
		;;
	4)
		clear
		menu
		;;
	*)
		clear
		echo -e "\033[31mYour Enter Error! Please input Choice:[1-4]\033[0m"
		lnmp_menu
esac

}

clear
menu
while true;do
	read -p "####Please Enter Your First_menu  Choice:[1-4]:" num1
	expr $num1 +1 &>/dev/null # 判断输入是否为整数
	if [ $? -ne 0  ];then
		echo "####################################"
		echo "Error!Please Enter Right Choice[1-4]!"
		echo "####################################"
		sleep 1
	fi
	case $num1 in
		1)
			clear
			lamp_menu
			;;

		2)
			clear
			lnmp_menu
			;;
		3)
			clear
			break
			;;
		4)
			clear
			menu
			;;
		*)
			clear
			echo -e "\033[31mYour Enter Error! Please input Choice:[1-4]\033[0m"
			menu
	esac
done



: "
PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit ")
select opt in "${options[@]}"
do
	case $opt in
		"Option 1")
			echo "you chose choice 1"
			;;
		"Option 2")
			echo "you chose choice 2"
			;;
		"Option 3")
			echo "you chose choice 3"
			;;
		"")
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done
"

