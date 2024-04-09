#!/bin/bash

# 检查并重新启动使用nezha123/titan-edge镜像但已停止的容器

container_ids=$(docker ps -a --filter "ancestor=nezha123/titan-edge" --format "{{.ID}}")

for id in $container_ids; do
    status=$(docker inspect --format "{{.State.Status}}" $id)
  
    if [ "$status" = "exited" ]; then
        echo "Restarting stopped container with ID: $id"
        docker start $id
    fi
done

echo "Container check complete."
