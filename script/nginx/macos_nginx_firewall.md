
## Mac系统中防火墙开放nginx的80端口方法

`

 /usr/libexec/ApplicationFirewall/socketfilterfw --add nginx访问全路径(如：/usr/local/Cellar/nginx/1.10.0/bin/nginx)

#显示 The application is already a part of the firewall

 /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp nginx访问全路径(如：/usr/local/Cellar/nginx/1.10.0/bin/nginx)

#显示 Incoming connection to the application is permitted

`

执行完上面的方法后，Nginx应用程序出现在OS X防火墙上的“已批准的应用程序”列表中，还必须重新启动nginx才能生效
