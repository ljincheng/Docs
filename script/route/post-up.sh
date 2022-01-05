#!/bin/bash

os=`uname -s`

## ips16_group1=("10.50" "10.52"  "172.10" "139.9" "10.0")
## ips24_group1=("192.168.212" "192.168.0" "192.168.199"  "192.168.210" "113.108.182" "183.6.248")
ips16_group1=("10.50" "10.52"  "172.10" "139.9" "120.52" "106.39" "23.2" "23.202" "163.171" "116.0" "210.75")
ips24_group1=("192.168.212" "192.168.0" "192.168.199" "52.130.147" "192.168.90" "192.168.111" )
ipsFull_group1=("127.0.0.53")
# ips16_group2=("23.219" "113.96" "119.147" "14.29" "202.104" "125.94" "59.37" "121.9" "222.79" "14.215" "61.177" " 125.77" "183.2" "58.216" "222.186" "210.75")
ips16_group2=("23.219"  "119.147" "14.29" "202.104" "125.94" "59.37" "121.9" "222.79" "14.215" "61.177" " 125.77" "183.2" "58.216" "222.186" "210.75")


addRuleIP(){
net_gateway=$1
net_int=$2
ips=(` echo "$3"`)

ips_other=".0.0/16"
if [ ${net_int} == '24' ];then
ips_other=".0/24"
fi
if [ ${net_int} == '0' ];then
ips_other=""
fi
 
if [ ${os} == 'Darwin' ];then
	for i in ${!ips[*]}
	do
	echo "route -nv add ${ips[$i]}${ips_other} ${net_gateway}"
	sudo route -nv add ${ips[$i]}${ips_other} ${net_gateway}
	done
else
	for i in ${!ips[*]}
	do
	echo "ip rule add to ${ips[$i]}${ips_other} priority 1024"
	sudo ip rule add to ${ips[$i]}${ips_other} priority 1024
	done
fi


}

downRuleIP(){
ips16=(` echo "$2"`)
net_int=$1

ips_other=".0.0/16"
if [ ${net_int} == '24' ];then
ips_other=".0/24"
fi
if [ ${net_int} == '0' ];then
ips_other=""
fi

if [ ${os} == 'Darwin' ];then
	for i in ${!ips16[*]}
	do
	echo "route delete ${ips16[$i]}${ips_other}"
	sudo route delete ${ips16[$i]}${ips_other}
	done
else
	for i in ${!ips16[*]}
	do
	echo "ip rule delete to ${ips16[$i]}${ips_other}"
	sudo ip rule delete to ${ips16[$i]}${ips_other}
	done
fi

}

addMyRoute(){

net_gateway="10.50.41.254"
if [ ${os} == 'Darwin' ];then

## 查看默认路由netstat -r中的default
## 删除添加的路由方法：sudo route delete yyy.yyy.yyy.yy

net_gateway=`netstat -nr |grep 'default' |awk '{print $2}' |awk 'NR==2{print}'`

echo "当前默认网关:${net_gateway}"
## net_gateway=10.50.41.254
else

net_gateway=`netstat -nr |grep '0.0.0.0' | awk '{print $2}' | awk 'NR==2{print}'`
echo "当前默认网关:${net_gateway}"
fi

addRuleIP ${net_gateway} 16 "${ips16_group1[*]}"
addRuleIP ${net_gateway} 16 "${ips16_group2[*]}"
addRuleIP ${net_gateway} 24 "${ips24_group1[*]}"
addRuleIP ${net_gateway} 0 "${ipsFull_group1[*]}"

}

deleteMyRoute(){

downRuleIP 16 "${ips16_group1[*]}"
downRuleIP 16 "${ips16_group2[*]}"
downRuleIP 24 "${ips24_group1[*]}"
downRuleIP 0 "${ipsFull_group1[*]}"

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
