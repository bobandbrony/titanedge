#!/bin/bash

image_name="nezha123/titan-edge"  # 镜像名称
container_prefix="titan-edge-container"  # 容器名前缀
num_containers=5  # 需要启动的容器数量

for i in $(seq 1 $num_containers); do
    container_name="${container_prefix}-${i}"  # 定义容器名
    volume_path="$HOME/.titanedge$i:/root/.titanedge"  # 定义卷挂载路径，替换#为数字

    echo "启动容器: $container_name，卷挂载: $volume_path"

    docker run -d --name $container_name -v $volume_path $image_name
done