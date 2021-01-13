#!/bin/bash

os=`uname -s`

ips16_group1=("10.50" "10.52" "172.10" "139.9")
ips16_group2=("23.219" "14.29" "202.104" "125.94" "59.37" "121.9" "222.79" "61.177" " 125.77")


addRuleIP(){
net_gateway=$1
net_int=$2
ips=(` echo "$3"`)

for i in ${!ips[*]}
do
echo "sudo route -nv add ${ips[$i]}.0.0/${net_int} ${net_gateway}"
sudo route -nv add ${ips[$i]}.0.0/${net_int} ${net_gateway}
done

}

downRuleIP(){
ips16=(` echo "$2"`)
net_int=$1
for i in ${!ips16[*]}
do
echo "sudo route delete ${ips16[$i]}.0.0/${net_int}"
sudo route delete ${ips16[$i]}.0.0/${net_int}
done
}

addMyRoute(){
if [ ${os} == 'Darwin' ];then

## 查看默认路由netstat -r中的default
## 删除添加的路由方法：sudo route delete yyy.yyy.yyy.yy

net_gateway=`netstat -nr |grep 'default' |awk '{print $2}' |awk 'NR==2{print}'`

echo "当前默认网关:${net_gateway}"
## net_gateway=10.50.41.254
addRuleIP ${net_gateway} 16 "${ips16_group1[*]}"
addRuleIP ${net_gateway} 16 "${ips16_group2[*]}"
else

#sudo ip rule add to 45.249.0.0/24 priority 1024
#sudo ip rule add to 10.0.0.0/16 priority 1024
echo "linux add rule"
fi

}

deleteMyRoute(){
if [ ${os} == 'Darwin' ];then
downRuleIP 16 "${ips16_group1[*]}"
downRuleIP 16 "${ips16_group2[*]}"
else
echo "linux delete rule"
fi
}



#net_ip=`netstat -nr |grep 'default' |awk '{print $2}' |awk 'NR==2{print}'`
#echo "net IP=${net_ip}"

main_start(){

tip_text="接收参数add|delete|exit"

echo "${tip_text}"

while read cmd
do
cmd_name=${cmd%% *}
case ${cmd%% *} in
add )
addMyRoute
;;

delete )
deleteMyRoute
;;

exit )
echo  "GOOD BYE"
break
;;
*)
echo "${tip_text}"
;;
esac

done
}

main_start
