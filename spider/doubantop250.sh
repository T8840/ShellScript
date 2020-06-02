#!/bin/bash
# Desc: spider https://movie.douban.com/top250

for i in {0..10}
do
	page=$[i*25]
	movie_name=`curl https://movie.douban.com/top250?start=$page |  grep '<img width="100"' |  awk -F '"' '{ print $4 }'`
	echo $movie_name
	sleep 1
done


