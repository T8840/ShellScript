#!/bin/bash

function menu(){
cat << EOF
--------------------------------------------------
|***************** Help Tips ********************|
--------------------------------------------------
* `echo -e "\033[35m -f file \033[0m"`
* `echo -e "\033[35m -h help tips \033[0m"`
* `echo -e "\033[35m -i install software \033[0m"`
EOF
}

function install(){
	# docker and docker-compose 
	# python/java/..
	#
	menu
}

function gcc_install(){
	# 安装gcc、c++编译器和内核文件
	yum -y install gcc gcc-c++ kenel-devel
}

while getopts ":f:i:h" opt
do
	case $opt in
		f)
			# 判断当前路径有没有文件，无的话终止
			work_dir=$(cd $(dirname $0); pwd)
			work_path='/'${OPTARG}
			work_path=$work_dir$work_path
			echo $work_path
			if [  -f $work_path  ];then
				for line in `cat ${work_path}`
				do
					echo $line
				done
			else
				echo "不存在指定文件，请重新输入"
				exit 1
			fi
			;;
		i)
			case  $OPTARG in
				docker)
					echo "Installing Docker And Docker-compose..."
					;;
				mysql)
					echo "Installing Mysql..."
					;;
				gcc)
					echo "Installing GCC..."
					gcc_install
					if ! [ -x "$(command -v gcc )" ];then
						echo "Error:gcc is not installed.">&2
						exit 1
					fi
					;;
				*)
					echo "其他暂时不支持。。"
					exit 1;;
			esac	
			;;
		h)
			menu
			;;
		?)
			echo "weizhi"
			exit 1;;
	esac
done

