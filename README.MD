# 安纳斯|整站前端模板抓取脚本 v0.8
本项目为shell实现的整站模板抓取工具，便于前端模板资源的收集与学习。
# 使用方法
- 操作系统 linux, suggest Debian 64bit

- 依赖工具 wget

- WEB环境 nginx

``` bash
# 请输入站点地址，如：
./getsite.sh http://www.baidu.com"

```

# 脚本目录说明
```
getsite.sh # 用于抓取整站,参数一为完整网页地址,如:http://www.baidu.com
rsync.sh # 用于将抓取的整站同步到线上服务器
index.html # 模板站点引导文件
README.MD # 说明文档
```
# 整站修正工作
## 情景一：非.html后缀问题
抓取静态页面URL存在.aspx等后缀文件，如何转为html静态页面浏览?

nginx文件中增加；
```
# 所有后缀解析为html静态页面
add_header Content-Type 'text/html; charset=utf-8';
```
## 情景二：URI中存在ask_end.aspx?cid=28等?字符
地址栏中URL为 xxx/ask_end.aspx?cid=28

文件夹中实际路径为 xxx/ask_end.aspx\?cid=28

```
# ?符号在Unicode编码中为&#63;
# 替换掉href中的URL地址即可
sed -i "s/aspx\?/aspx\&\#63\;/g" `grep -rl "aspx\?"`

```

# Nginx环境配置
```
# File: /etc/nginx/site-available/anas_case
server {
        listen 80;
        listen [::]:80;

        server_name case.anasit.com;

        root /var/www/template;
        index index.html index.htm;

        location / {
                # 任意后缀文件,解析为html静态页面
                add_header Content-Type 'text/html; charset=utf-8';
                try_files $uri $uri/ =404;
        }
}

```

# Contributor

- CIO [ryanemax](https://ryanamax.github.io/), The Author.

# Copyright

http://www.anasit.com

Copyright © 2015 ANAS IT Inc. All Rights Reserved

