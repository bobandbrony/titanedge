#!/bin/bash

# 询问用户想要创建的titanedge项目数量
read -p "请输入你想要创建的titanedge项目数量（n）: " n

# 询问用户设置的StorageGB大小
read -p "请输入你想为每个项目设置的StorageGB大小: " storage_gb

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

# 验证hash值
hash_valid=false
while [ "$hash_valid" = false ]; do
    read -p "请输入hash值: " user_hash
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "{\"hash\":\"$user_hash\"}" "https://api-test1.container1.titannet.io/api/v2/device/binding")
    if [ "$response" = "200" ]; then
        echo "Hash值验证成功。"
        hash_valid=true
    else
        echo "Hash值验证失败，请重新输入。"
    fi
done

# 根据已存在的项目编号开始创建新项目
for ((i=1; i<=n; i++))
do
    # 这里添加创建项目和容器的相关代码
    # 以下是一个示例占位符命令
    echo "这里将会是创建项目和容器的相关命令，当前正在处理第 $i 个项目。"
    # 注意替换或添加你的实际命令和逻辑
done

echo "所有指定的titanedge项目已成功处理。"
