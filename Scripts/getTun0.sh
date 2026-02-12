#!/bin/bash
result=$(ip a show tun0 2>/dev/null | grep -oP 'inet \K[0-9.]+(?=/)')
if [ -z "$result" ]; then
    echo -n "What did you expect?" | wl-copy
else
    echo -n "$result" | wl-copy
fi
