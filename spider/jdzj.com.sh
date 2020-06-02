#!/bin/bash
# Desp: spider www.jdzj.com

# 设置信号
trap "exec 6>&- exec 6<&-;exit 0" 2

mkfifo testfifo
exec 6<>testfifo
rm -rf testfifo

Thread=128
for ((n=0;n<$Thread;n++))
do
	echo >&6
done

# 设置计时器
seconds_l=$(date +%s)

