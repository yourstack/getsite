#!/bin/sh
if [ $# -eq 0 ]       ##判断参数是否存在
then
	echo "请输入站点地址，如：./getsite.sh http://www.baidu.com"
	exit                     ##不存在退出
fi
targetSite=$1
wget -r -p -np -k -e robots=off --restrict-file-names=unix ${targetSite}
