#!/bin/bash

# 定义要监测的Docker容器前缀
container_prefix="titanedge_"

# 检测存在的titanedge_#容器并存储到数组中
existing_containers=($(docker ps -a --format "{{.Names}}" | grep "^${container_prefix}"))

# 遍历所有检测到的容器
for container_name in "${existing_containers[@]}"
do
    # 检查容器是否在运行
    running=$(docker inspect --format="{{ .State.Running }}" $container_name 2> /dev/null)

    if [ $? -eq 1 ]; then
        echo "容器 ${container_name} 不存在."
    elif [ "$running" == "false" ]; then
        echo "容器 ${container_name} 不在运行状态，尝试启动..."
        # 尝试启动容器
        docker start $container_name
    else
        echo "容器 ${container_name} 正在运行."
    fi
done