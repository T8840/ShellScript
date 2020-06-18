#!/bin/bash
# Desc: Send Data To https://pasteme.cn
if [ $# -ne 1 ];then
	echo "Usage:$0 filename"
	exit 1
fi
file=$1
if [ ! -f $file ];then
	echo "the $file is not a file"
	exit 2
fi
re=`python3 pasteme3.py $file`
echo $re

#resp=`curl -H "Content-Type:application/json" -X POST  -d '{"content":"'${content}'","lang":"plain"}'  api.pasteme.cn`
#echo $resp

