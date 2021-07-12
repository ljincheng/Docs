
一、服务端

创建远程仓库只需要二步：

git init --bare xxx.git
chown -R username xxx.git/

例如：

git init --bare demo.git
chown -R root demo.git/

二、终端

git clone ssh://username@ip:/xxx.git的路径

例如：

git clone ssh://root@127.0.0.1:/user/root/git/demo.git
