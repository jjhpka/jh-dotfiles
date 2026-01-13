#!/bin/bash
# Claude Code 알림을 Windows 데스크톱 알림으로 전송 (BurntToast 사용)

# stdin에서 JSON 입력 받기
input=$(cat)
message=$(echo "$input" | jq -r '.message // "Claude Code 알림"')
notification_type=$(echo "$input" | jq -r '.notification_type // "general"')

# 알림 타입에 따른 제목 설정
case "$notification_type" in
  "permission_prompt")
    title="Claude Code - 권한 요청"
    ;;
  "idle_prompt")
    title="Claude Code - 입력 대기 중"
    ;;
  "auth_success")
    title="Claude Code - 인증 성공"
    ;;
  *)
    title="Claude Code"
    ;;
esac

# BurntToast로 Windows 알림 전송
powershell.exe -Command "
Import-Module BurntToast -ErrorAction SilentlyContinue
New-BurntToastNotification -Text '$title', '$message' -AppLogo 'C:\Users\jeonghun\claude-code.png'
" 2>/dev/null &

exit 0
