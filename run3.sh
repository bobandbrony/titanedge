#!/bin/bash

# 定义GitHub上脚本的URL
SCRIPT_URL="https://raw.githubusercontent.com/bobandbrony/titanedge/main/shouhu2.sh"
SCRIPT_PATH="$HOME/shouhu2.sh"

# 下载脚本
curl -o $SCRIPT_PATH $SCRIPT_URL

# 使脚本可执行
chmod +x $SCRIPT_PATH

# 添加Cron任务
(crontab -l 2>/dev/null; echo "*/5 * * * * $SCRIPT_PATH") | crontab -
