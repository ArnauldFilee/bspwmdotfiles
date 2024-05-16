#!/bin/bash
message=$(pamixer --get-volume-human | tr -d '%')

dunstify -h string:x-canonical-private-synchronous:audio -t 1000 "  $message" -h int:value:"$message"