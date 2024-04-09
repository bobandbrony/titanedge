#!/bin/bash

# 询问用户想要创建的titanedge项目数量
read -p "请输入你想要创建的titanedge项目数量（n）: " n

# 询问用户输入hash值
read -p "请输入你的身份码（只需要输入一个）: " user_hash

# 询问用户设置的StorageGB大小
read -p "请输入你想为每个项目设置的StorageGB大小（如果不知道怎么填，请输入2）: " storage_gb

# 检查并拉取最新的nezha123/titan-edge镜像
echo "正在检查并拉取最新的nezha123/titan-edge镜像..."
docker pull nezha123/titan-edge

# 查找已存在的最大项目编号
max_existing_id=0
for dir in ~/.titanedge*; do
  if [[ -d $dir && $dir =~ ~/.titanedge([0-9]+)$ ]]; then
    id=${BASH_REMATCH[1]}
    if (( id > max_existing_id )); then
      max_existing_id=$id
    fi
  fi
done

# 根据已存在的项目编号开始创建新项目
for ((i=1; i<=n; i++))
do
    new_id=$((max_existing_id + i))
    project_path="$HOME/.titanedge$new_id"
    echo "正在处理titanedge$new_id..."
    echo "创建目录 $project_path..."
    mkdir -p "$project_path"
    container_name="titanedge_$new_id"
    echo "启动容器 $container_name..."
    CONTAINER_ID=$(docker run -d --name $container_name -v "$project_path:/root/.titanedge" nezha123/titan-edge)
    sleep 10 # 等待容器初始化并生成默认的config.toml文件
    echo "修改config.toml文件..."
    docker exec -it $CONTAINER_ID /bin/bash -c "sed -i '/StorageGB/c\  StorageGB = $storage_gb' /root/.titanedge/config.toml"
    echo "重启容器以应用配置更改..."
    docker restart $CONTAINER_ID
    sleep 5 # 给容器一些时间来完成重启
    echo "正在尝试绑定身份码..."
    success=false
    attempts=0
    max_attempts=5
    while [ $attempts -lt $max_attempts ]; do
        docker exec -it $CONTAINER_ID /bin/bash -c "titan-edge bind --hash=$user_hash https://api-test1.container1.titannet.io/api/v2/device/binding" && success=true && break
        attempts=$((attempts+1))
        echo "绑定失败，正在进行第 $attempts 次重试..."
        sleep 5
    done
    if [ $success = true ]; then
        echo "身份码成功绑定到titanedge$new_id."
    else
        echo "身份码绑定失败，请手动检查titanedge$new_id."
    fi
done

echo "所有指定的titanedge项目已成功处理。"
