#!/usr/bin/env bash

shopt -s nullglob globstar

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | wofi --dmenu --matching=fuzzy "$@")

[[ -n $password ]] || exit

pass show -c "$password" 2>/dev/null

