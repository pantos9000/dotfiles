#!/bin/bash
set -euo pipefail

TOTP=${1:-}

shopt -s nullglob globstar

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | wofi --dmenu --matching=fuzzy "$@")

[[ -n $password ]] || exit

if [ "$TOTP" = "totp" ]; then
    pass otp -c "$password" 2>/dev/null
else
    pass show -c "$password" 2>/dev/null
fi
