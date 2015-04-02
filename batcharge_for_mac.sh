#!/bin/sh -

readonly TOTAL_SLOTS=10
readonly COLOR_GREEN='\033[32m'
readonly COLOR_YELLOW='\033[33m'
readonly COLOR_RED='\033[31m'
readonly COLOR_RESET='\033[0m'

print_repeat() {
    printf '%*s\n' "$2" '' | tr ' ' "$1"
}

main() {
#    local battery_percent="$(pmset -g batt | grep -F 'InternalBattery' | cut -d ';' -f 1 | cut -f 2 | grep -o '^[[:digit:]]\{1,\}')"
    local battery_info="$(/usr/sbin/ioreg -arc AppleSmartBattery)"
    local current_capacity="$(printf '%s\n' "$battery_info" | xmllint --xpath '/plist/array/dict/key[text() = "CurrentCapacity"]/following::integer[1]/text()' -)"
    local max_capacity="$(printf '%s\n' "$battery_info" | xmllint --xpath '/plist/array/dict/key[text() = "MaxCapacity"]/following::integer[1]/text()' -)"
    local battery_percent="$(expr 100 '*' "$current_capacity" '/' "$max_capacity" )"
    local filled="$(expr "$battery_percent" '*' "$TOTAL_SLOTS" '/' 100)"
    local empty="$(expr "$TOTAL_SLOTS" '-' "$filled")"
    local filled_slots="$(print_repeat '▸' "$filled")"
    local empty_slots="$(print_repeat '▹' "$empty")"
    local slots="${filled_slots}${empty_slots}"
    local color_out=''
    if [ "$battery_percent" -gt 60 ]; then
        color_out="$COLOR_GREEN"
    elif [ "$battery_percent" -gt 40 ]; then
        color_out="$COLOR_YELLOW"
    else
        color_out="$COLOR_RED"
    fi
    printf '%b%s%b\n' "$color_out" "$slots" "$COLOR_RESET"
}

main "$@"
