if status is-interactive
    # Commands to run in interactive sessions can go here
end

# include hostname-dependent config
for file in $HOME/.config/fish/conf.$hostname.d/*.fish
    source $file
end

# Hide welcome message & ensure we are reporting fish as shell
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xU MANROFFOPT "-c"
set -x SHELL /usr/bin/fish


# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end
