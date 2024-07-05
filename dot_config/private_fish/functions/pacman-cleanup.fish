# Cleanup local orphaned packages
function pacman-cleanup
    while pacman -Qdtq
        sudo pacman -R (pacman -Qdtq)
    end
end
