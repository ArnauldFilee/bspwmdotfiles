#!/bin/bash
message=$(brightnessctl i | grep '%' | awk '{print $4}' | tr -d '()%')
dunstify -h string:x-canonical-private-synchronous:brightness -t 1000 "󰃝  $message" -h int:value:"$message"