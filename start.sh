#!/bin/bash

image_name="nezha123/titan-edge"  # 镜像名称

# 检查家目录下所有的.titanedge相关目录，包括特殊情况的/.titanedge
for dir in $(ls $HOME | grep '\.titanedge'); do
    # 特殊情况处理：如果目录名称为.titanedge，则将容器名称设置为titanedge_0
    if [ "$dir" == ".titanedge" ]; then
        container_name="titanedge_0"
    else
        # 提取数字部分
        dir_number=$(echo $dir | grep -o '[0-9]*')
        # 构造容器名称
        container_name="titanedge_$dir_number"
    fi

    # 检查是否有对应的容器正在运行
    running_container=$(docker ps --filter "name=^/${container_name}$" --format "{{.Names}}")

    if [ -z "$running_container" ]; then
        # 容器不存在或未运行
        volume_path="$HOME/$dir:/root/.titanedge"  # 定义卷挂载路径
        echo "启动容器: $container_name，卷挂载: $volume_path"
        docker run -d --name $container_name -v $volume_path $image_name
    else
        echo "容器 $container_name 已经在运行."
    fi
done