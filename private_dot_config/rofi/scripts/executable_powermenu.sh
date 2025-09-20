#!/bin/bash

# 選項定義
CHOICE=$(echo -e "🔒 鎖定\n📴 關機\n🔁 重啟\n🚪 登出\n💤 睡眠" | rofi -dmenu -p "電源選單" -i -width 20 -lines 6)

case "$CHOICE" in
  "🔒 鎖定") i3lock ;;
  "📴 關機") systemctl poweroff ;;
  "🔁 重啟") systemctl reboot ;;
  "🚪 登出") i3-msg exit ;;
  "💤 睡眠") systemctl suspend ;;
  *)
    # 使用者取消或其他操作
    exit 0
    ;;
esac

