#!/bin/sh
### shell_history.sh
### sh_log.sh



_user="$(whoami)@$(hostname)";
_time="$(date +%Y_%m_%d,%H_%M_%S,%N)";
_place_hw="$(ifconfig eth0 | grep HWaddr | awk '{ print $5 }' | sed -e 's/:/_/g')";
_place_pwd="$(pwd | sed -e 's/\//_/g')";
_place_tty="$(tty | sed -e 's/\//_/g')";
_place="${_place_hw},${_place_tty},${_place_pwd}";


_file="sh_history#who=\"${_user}\"&when=\"${_time}\"&where=\"${_place}\"";
echo ""
echo "$_file"

# history

