if status is-interactive
    # Commands to run in interactive sessions can go here
end

# include hostname-dependent config
for file in $HOME/.config/fish/conf.$hostname.d/*.fish
    source $file
end
