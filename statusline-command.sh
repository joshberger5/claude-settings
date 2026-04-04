#!/usr/bin/env bash

# Read all stdin once
input=$(cat)

# Use Python (py) to parse JSON since jq is not installed on this machine
parse() {
    echo "$input" | py -c "
import sys, json
data = json.load(sys.stdin)
key = '$1'
parts = key.split('.')
val = data
try:
    for p in parts:
        if p:
            val = val[p]
    print(val if val is not None else '')
except (KeyError, TypeError):
    print('')
" 2>/dev/null
}

# Current directory
cwd=$(parse "workspace.current_dir")
if [ -z "$cwd" ]; then
    cwd=$(parse "cwd")
fi
if [ -n "$cwd" ]; then
    cwd_display="${cwd//\\//}"
    # Normalize Windows drive letter (C:/...) to bash-on-Windows style (/c/...) for HOME comparison
    cwd_normalized="$cwd_display"
    if [[ "$cwd_normalized" =~ ^([A-Za-z]):(/.*)$ ]]; then
        drive="${BASH_REMATCH[1],,}"   # lowercase drive letter
        rest="${BASH_REMATCH[2]}"
        cwd_normalized="/${drive}${rest}"
    fi
    # Show only the basename (project folder name)
    cwd_display="${cwd_display##*/}"
else
    cwd_display=""
fi

# Tokens
total_input=$(parse "context_window.total_input_tokens")
total_output=$(parse "context_window.total_output_tokens")
total_input=${total_input:-0}
total_output=${total_output:-0}
total_tokens=$(( total_input + total_output ))
formatted=$(printf "%'d" "$total_tokens" 2>/dev/null || echo "$total_tokens")

# Cost estimate — input $3/M, output $15/M (Sonnet 4.x)
cost=$(echo "$total_input $total_output" | awk '{
    cost = ($1 / 1000000 * 3.00) + ($2 / 1000000 * 15.00)
    printf "$%.4f", cost
}')

# Context bar (16.5% auto-compact buffer)
AUTO_COMPACT_BUFFER_PCT=16.5
remaining_pct=$(parse "context_window.remaining_percentage")
used_pct=$(parse "context_window.used_percentage")

if [ -z "$remaining_pct" ] && [ -n "$used_pct" ] && [ "$used_pct" != "" ]; then
    remaining_pct=$(echo "$used_pct" | awk '{print 100 - $1}')
fi
if [ -z "$remaining_pct" ]; then
    remaining_pct=100
fi

used=$(echo "$remaining_pct $AUTO_COMPACT_BUFFER_PCT" | awk '{
    remaining = $1
    buffer = $2
    usable = (remaining - buffer) / (100 - buffer) * 100
    if (usable < 0) usable = 0
    u = 100 - usable
    if (u < 0) u = 0
    if (u > 100) u = 100
    printf "%d", int(u + 0.5)
}')

filled=$(( used / 10 ))
empty=$(( 10 - filled ))
bar=""
for ((i=0; i<filled; i++)); do bar="${bar}█"; done
for ((i=0; i<empty; i++)); do bar="${bar}░"; done

if [ "$used" -lt 50 ]; then
    color=$'\e[32m'
elif [ "$used" -lt 65 ]; then
    color=$'\e[33m'
elif [ "$used" -lt 80 ]; then
    color=$'\e[38;5;208m'
else
    color=$'\e[5;31m'
fi
reset=$'\e[0m'

if [ "$used" -ge 80 ]; then
    skull=$'\U0001F480'
else
    skull=""
fi

ctx_str="${color}${skull}${bar}${reset} ${used}%"

# Assemble
parts=()
[ -n "$cwd_display" ] && parts+=("$cwd_display")
parts+=("${formatted} tokens")
parts+=("${cost}")
parts+=("$ctx_str")

output=""
for part in "${parts[@]}"; do
    if [ -z "$output" ]; then
        output="$part"
    else
        output="${output} | ${part}"
    fi
done

printf '%s\n' "$output"
