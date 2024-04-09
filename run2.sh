#!/bin/bash

# GitHub上脚本的URL
SCRIPT_URL="https://raw.githubusercontent.com/bobandbrony/titanedge/main/shouhu.sh"

# 脚本保存的路径
SCRIPT_PATH="/root/shouhu.sh"

# 下载脚本
curl -o $SCRIPT_PATH $SCRIPT_URL

# 给脚本执行权限
chmod +x $SCRIPT_PATH

# 设置Cron作业，每5分钟运行一次脚本
(crontab -l 2>/dev/null; echo "*/5 * * * * $SCRIPT_PATH") | crontab -
