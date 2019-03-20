# 未来全栈|整站前端模板抓取脚本 v0.8
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
## 情景零：中文URL乱码问题
``` bash
# getsite.sh加入参数
--restrict-file-names=OS
# wget: --restrict-file-names: Invalid restriction ‘OS’,
#     use [unix|vms|windows],[lowercase|uppercase],[nocontrol],[ascii].
```

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
## 情景三：资源从/根目录获取导致404错误
html根目录地址
```
# html中,/会导致URL从根目录获取
src="/Scripts/underscore.js"
# 修改为如下路径
src="/newmbone.wezhan.cn/Scripts/underscore.js"
# 批量替换脚本
sed -i "s/=\"\//=\"\/newmbone.wezhan.cn\//g" `grep -rl "=\"\/"`
```
# ?符号在Unicode编码中为&#63;
# 替换掉href中的URL地址即可
sed -i "s/aspx\?/aspx\&\#63\;/g" `grep -rl "aspx\?"`

```
## 情景四：Render统一管理的css无法正常加载

css后根目录地址
```
# 下载html中RenderCss文件，
RunTime/RenderRunTimeCss?cid=content%2Fsitefiles5%2F5552%2Fcss%2Fpc%2F42451_zh-CN.css%3Fdt%3D635751159446896412
# 替换RunTime目录文件为真实名称
mv RunTime/RenderRunTimeCss?cid=content%2Fsitefiles5%2F5552%2Fcss%2Fpc%2F42451_zh-CN.css%3Fdt%3D635751159446896412 1265_zh-CN.css
# 批量替换脚本（正则匹配多种Render随机路径，替换为正确文件）
sed -i "s/RenderRunTimeCss.*[0-9]\ /1265_zh-CN.css/g" `grep -rl 'RenderRunTimeCss.*[0-9]\ '`
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

- CSO [ryanemax](https://www.futurestack.cn/), The Author.

# Copyright

http://www.futurestack.cn

Copyright © 2015 FutureStack Inc. All Rights Reserved

