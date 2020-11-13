#!/bin/bash

echo "创建容器脚本"

docker_name="app-codework"
docker_image_name="ljincheng/app-codework:1.0.0"
docker_dockerfile="/opt/apps/codework/Dockerfile_springboot"
docker_params=" -v /opt/apps/codework/apps:/opt/apps -p 8075:8075 "
docker_spring_profiles_active=" --spring.profiles.active=prod"
docker_jar="codework-application.jar"

curPath=$(readlink -f "$(dirname "$0")")
echo $curPath
cd $curPath

function image_update(){
if [[ -f "${docker_jar}" ]]; then
echo "更新JAR文件:${docker_jar}"
mv ${docker_jar} apps/
fi
}
function image_build(){

docker_image_id="$(docker images -q ${docker_image_name})"
echo "镱像:$docker_image_name(ID:${docker_image_id})"
if [[ "${docker_image_id}" == "" ]]; then
echo "准备创建${docker_image_name}容器镜像"

docker build -f ${docker_dockerfile}  -t ${docker_image_name} .
#docker build -f ${docker_dockerfile} --build-arg jarFile=${docker_jar} -t ${docker_image_name} .

fi
}

function image_run(){

docker_count=$(docker ps -a --filter "name=${docker_name}"|grep "${docker_name}"|wc -l)
echo "docker_count=${docker_count}"
if [[ $docker_count > 0 ]]; then
docker stop ${docker_name}
image_update
echo "启动镜像服务:${docker_name}"
docker start ${docker_name}

fi

if [[ $docker_count = 0 ]]; then
echo "创建镜像服务：${docker_name}"

image_update
## docker run -d -it  -v /opt/apps/codework/apps:/opt/apps -p 8075:8075 --name "codework"  ljincheng/app-codework:1.0.0 --spring.profiles.active=prod
docker run -d --privileged=true ${docker_params} --name ${docker_name}  ${docker_image_name} ${docker_spring_profiles_active}

fi


}
 

image_build
image_run

