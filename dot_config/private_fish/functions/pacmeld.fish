function pacmeld
    if not command -v pacdiff > /dev/null;
        echo "pacdiff not found." 1>&2
        return 1
    end
    if not command -v meld > /dev/null;
        echo "meld not found." 1>&2
        return 1
    end

    if [ "XDG_SESSION_TYPE" = "wayland" ]
        echo "enter root password." 1>&2
        command su -c "DIFFPROG=meld pacdiff"
    else
        command sudo DIFFPROG=meld pacdiff
    end

    echo "all pacfiles melded." 1>&2
end
