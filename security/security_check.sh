#!/bin/bash
echo '-----Check Now Login Record-----'
login_record_ip=`netstat -ntu | grep tcp | awk '{ print $5 }' | cut -d ':' -f 1 ` # cut命令是为了去掉端口
login_record_log=`tail -n 1000 /var/log/secure | grep "Failed password" | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -nr | uniq -c | awk '$1>=4 {print $2}'`
login_record_user=`w`
echo -e "------当前登录IP：------"
echo "${login_record_ip}"
echo -e "------当前登录的终端有：------"
echo "${login_record_user}"
echo -e "------恶意攻击IP地址有：------"
echo "${login_record_log}"


echo 'Check Last Login Record'
login_record_ip=``
login_record_user=`w`
login_record_log=``


echo '######Check Sentivie File######'
declare -A check_file_dic
check_file_dic=(['/etc']='drwxr-xr-x.' ['/etc/passwd']='-rw-r--r--' ['/etc/group']='-rw-r--r--')
for key in $(echo ${!check_file_dic[*]})
do
	echo "现在将要检查文件对应的权限：$key : ${check_file_dic[$key]}"
        file_chmod=$(ls -ld ${key} | awk '{print $1}')
	echo "${key}文件实际对应的权限: ${file_chmod}"
	if [[ ${check_file_dic[$key]} == ${file_chmod} ]]; then
		echo "check ok"
	else
		echo "check fail"
	fi
done	


echo '######Check PID-/proc######'
woodenflag=0
str_pids="`ps -A | awk '{print $1}'`"
for i in /proc/[[:digit:]]*
do
	if [ echo "$str_pids" | grep -qs `basename "$i"` ];then
	        echo "ok"	
	else
		((woodenflag++))
		echo "Rootkit PID: $(basename "$i")"
	fi
done
		
