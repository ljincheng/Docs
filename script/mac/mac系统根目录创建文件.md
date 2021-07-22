
## 在 Mac Catalina 的 root 目录创建虚拟文件

### 第一步 编辑/etc/synthetic.conf  配置

sudo vi /etc/synthetic.conf

 编辑/etc/synthetic.conf，按下面规则键入你想要创建的虚拟文件夹或映射,注意必须使用tab 键分隔

foo     #将在root创建foo文件夹
bar	/Users/bar   #将bar链接到/Users/bar,注意必须使用 tab 键分隔
logs	/opt/wz_workspace/logs


### 第二步 重启电脑生效。
reboot 重启电脑才生效。


## 注意事项

注意必须使用 tab 键分隔，否则重启不会生效

