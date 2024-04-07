for container_id in $(docker ps | grep nezha123/titan-edge | awk '{ print $1 }'); do
    docker restart $container_id
done