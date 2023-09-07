#!/bin/sh
## 同步所有抓取的站点模板到线上服务器
## http://case.anasit.com/xxx.xxx.com
rsync -azP ./ root@api.xxx.com:/var/www/demo_case
