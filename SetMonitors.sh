#!/bin/bash

# Configure external display using xrandr. 
# Allows setting up the secondary display position.

RED="\e[0;31m\033[22m"
GRE="\e[0;32m\033[22m"
END="\033[0m\e[0m"

die() {
    echo -e "${RED}Error: $1${END}" >&2
    exit 1
}

if [ "$#" -ne 1 ]; then
    die "Usage: $0 [right/left/above/below]"
fi

case $1 in
    right|left|above|below)
        pos="${1}-of" ;;
    *)
        die "Invalid position '$1'" ;;
esac

int_display=$(xrandr --listmonitors | grep "0:" | awk '{print $4}')
[ -z "$int_display" ] && die "No integrated display detected"
int_resolution=$(xrandr | grep -A1 "^$int_display connected" | tail -n1 | awk '{print $1}' | tr -d '[:space:]')

ext_display=$(xrandr --listmonitors | grep "1:" | awk '{print $4}')
[ -z "$ext_display" ] && die "No external display detected"
ext_resolution=$(xrandr | grep -A1 "^$ext_display connected" | tail -n1 | awk '{print $1}' | tr -d '[:space:]')

configure_display() {
    local position="$1"
    local int_mode="$2"
    local ext_mode="$3"

	xrandr --output "$int_display" --primary --mode "$int_mode" --output "$ext_display" --mode "$ext_mode" --"$position" "$int_display"
}

configure_display "$pos" "$int_resolution" "$ext_resolution"

