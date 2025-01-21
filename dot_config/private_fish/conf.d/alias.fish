# Replace ls with eza
alias ls 'eza -al --color=always --group-directories-first --icons' # preferred listing
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll 'eza -l --color=always --group-directories-first --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# Get the error messages from journalctl
alias jctl 'journalctl -p 3 -xb'

# Recent installed packages
alias rip 'expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'

# replacements
alias cat 'bat --style header --style snip --style changes --style header'
alias grep 'rg --color=auto'
alias egrep 'rg -E --color=auto'
alias fgrep 'rg -F --color=auto'

# colorize
alias ip 'ip -color'
alias tree='tree -C'
alias less='less -R'
alias dmesg='dmesg --color=always -H'

# dir movement
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'

# convenience/util
alias pacdiff 'sudo -H DIFFPROG=meld pacdiff'
alias agl='ag --pager="less -R"'
alias vim='nvim'
alias hw 'hwinfo --short'                          # Hardware Info
alias fixpacman 'sudo rm /var/lib/pacman/db.lck'
alias printconfig='system-config-printer'
alias print='lpr'
alias beep='play /usr/share/sounds/freedesktop/stereo/bell.oga > /dev/null 2>&1'
alias wget 'wget -c '

# Get fastest mirrors
alias mirror 'sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
alias mirrora 'sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist'
alias mirrord 'sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist'
alias mirrors 'sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'

# fzf aliases
alias f-search '_fzf_search_directory'
alias f-git-log '_fzf_search_git_log'
alias f-git-status '_fzf_search_git_status'
alias f-processes '_fzf_search_processes'
alias f-env-vars '_fzf_search_variables'

# cargo update
alias cargo-update 'cargo install-update'

alias ipython ipython3

# flatseal
alias flatseal "flatpak run com.github.tchx84.Flatseal"

# backup
alias backup "deja-dup"

# disable vi
alias vi "nvim"
