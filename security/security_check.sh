#!/bin/bash
echo '-----Check Now Login Record-----'
login_record_ip=`netstat -ntu | grep tcp | awk '{ print $5 }' | cut -d ':' -f 1 ` # cut命令是为了去掉端口
login_record_user=`w`
login_record_log=`tail -n 1000 /var/log/secure | grep "Failed password" | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -nr | uniq -c | awk '$1>=4 {print $2}'`
echo -e "------当前登录IP：------"
echo "${login_record_ip}"
echo -e "------恶意攻击IP地址有：------"
echo "${login_record_log}"


echo 'Check Last Login Record'
login_record_ip=``
login_record_user=`w`
login_record_log=``
