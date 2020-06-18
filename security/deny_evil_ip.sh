#!/bin/bash
# Desp : CentOS6默认使用iptables,CentOS7默认使用firewall,该脚本目前只针对firewall进行配置


# 如下为截取secure文件恶意ip远程登录22端口，大于等于4次就写入防火墙黑名单
# egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" 匹配ip
# sort -nr | uniq -c 对ip排序，并在开头加上该ip出现的次数
IP_ADDR=`tail -n 1000 /var/log/secure  | grep "Failed password" | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -nr | uniq -c | awk '$1>=3 {print $2}'`
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


# 如下为根据web日志的访问量自动拉黑IP
echo 
cat <<EOF
+++++++++welcome to use web_log drop failed ip+++++++++
EOF

# 参考代码
: '
line1=`wc -l /access_log|awk '{print$1}'`
cp /var/log/httpd/access_log /
 
#计算现有的日志有多少行
line2=`wc -l /var/log/httpd/access_log |awk '{print$1}'`
 
#根据上一次备份的日志和现在拥有的行数差值，作为单位时间内分析日志访问量
tail -n $((line2-line1)) /var/log/httpd/access_log|awk '{print$1}'|sort -n|uniq -c|sort >/1.txt
 
cat /1.txt|while read line
do 
	echo $line >/line
	num=`awk '{print$1}' /line`
	 
	#设定阀值num，单位时间内操作这个访问量的ip会被自动拉黑
	if (($num>12))
	then
		ip=`awk '{print$2}' /line`
		firewall-cmd --add-rich-rule="rule family=ipv4 source address='${ip}' port port=80 protocol=tcp reject" --permanent
		firewall-cmd --reload
	fi
done

'



# 最后重启firewall生效
firewall-cmd --reload
