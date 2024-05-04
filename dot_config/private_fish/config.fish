if status is-interactive
    # Commands to run in interactive sessions can go here
end

# include hostname-dependent config
source $HOME/.config/fish/conf.$hostname.d/*.fish
