#!/bin/sh
if [ $# -eq 0 ]       ##判断参数是否存在
then
	echo "请输入站点地址，如：./getsite.sh http://www.xxx.com"
	exit                     ##不存在退出
fi
targetSite=$1

# --no-clobber 不要覆盖已存在文件
mkdir -p site
cd site
wget -r -p -np -k -e robots=off --restrict-file-names=unix ${targetSite} --no-clobber
