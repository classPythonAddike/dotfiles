current="$(amixer -- sget Capture | cut -b 3- | grep ^Front\ Left | cut -d"[" -f 2 | cut -d"%" -f 1)"
new=$(($current - 5))

amixer sset Capture $new%

new=$(amixer -- sget Capture | cut -b 3- | grep ^Front\ Right | cut -d"[" -f 2 | cut -d"%" -f 1)

dunstify -a "changeVolume" -u low --raw_icon "/usr/share/icons/Adwaita/16x16/devices/audio-input-microphone-symbolic.symbolic.png" "Decreased Microphone Sensitivity" "Microphone Sensitivity: ${new}%"
