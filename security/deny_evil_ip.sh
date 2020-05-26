#!/bin/bash
# Desp : CentOS6默认使用iptables,CentOS7默认使用firewall,该脚本目前只针对firewall进行配置


# 如下为截取secure文件恶意ip远程登录22端口，大于等于4次就写入防火墙黑名单
# egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" 匹配ip
# sort -nr | uniq -c 对ip排序，并在开头加上该ip出现的次数
IP_ADDR=`tail -n 1000 /var/log/secure  | grep "Failed password" | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -nr | uniq -c | awk '$1>=4 {print $2}'`
echo 
cat <<EOF
+++++++++welcome to use ssh login drop failed ip+++++++++
EOF
echo "------需要添加到IP黑名单中的IP有：------"
echo ${IP_ADDR}
echo "----------------------------------------"
for i in `echo $IP_ADDR`
do
	# 查看firewalld配置文件是否含有提取的IP信息
	check=`firewall-cmd --list-all | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep ${i} `
	if [ $check  ];then
		echo " THis is $i is exist in firewall rules,please exit..."
	else
		firewall-cmd --permanent --add-rich-rule="rule family=ipv4 source address='${i}' drop"	
	fi
done
# 最后重启firewall生效
firewall-cmd --reload
