#!/bin/bash

CHOICE=$(echo -e "60\n80\n100" | rofi -dmenu -p "充電上限（%）")

# 使用者取消選擇
[ -z "$CHOICE" ] && exit 1

VALUE=$(echo "$CHOICE" | grep -o '[0-9]\+')
if [[ -z "$VALUE" ]]; then
    notify-send "⚠️ 無效的選項：" "$CHOICE"
    exit 1
fi

# 執行 systemd service
if systemctl start "charge-limit@${VALUE}.service"; then
    # 顯示通知
    notify-send "✅ 充電上限已設定" "上限設為 ${VALUE}%"
else
    notify-send "❌ 設定失敗" "無法啟動 charge-limit@${VALUE}.service"
    exit 1
fi

