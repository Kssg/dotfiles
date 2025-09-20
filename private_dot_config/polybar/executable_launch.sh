#!/usr/bin/env bash

# 結束所有正在執行的 polybar 實例
polybar-msg cmd quit

# 稍作等待以避免 race condition
# sleep 1

# 啟動 topbar
echo "---" | tee -a /tmp/polybar_top.log
polybar topbar 2>&1 | tee -a /tmp/polybar_top.log & disown
echo "Bars launched..."
