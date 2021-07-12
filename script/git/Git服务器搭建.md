## Git 服务器搭建 

### 1、安装Git

yum install git

接下来我们 创建一个git用户组和用户，用来运行git服务

(```)
groupadd git
useradd git -g git
(```)

### 2、创建证书登录

(```)
cd /home/git/
mkdir .ssh
chmod 755 .ssh
touch .ssh/authorized_keys
chmod 644 .ssh/authorized_keys
(```)

### 3、初始化Git仓库

(```)
cd /home
mkdir gitrepo
chown git:git gitrepo/
cd gitrepo
git init --bare runoob.git
chown -R git:git runoob.git
(```)

### 4、前端拉取、克隆仓库

(```)
git clone git@192.168.45.4:/home/gitrepo/runoob.git
(```)





