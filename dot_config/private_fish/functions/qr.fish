function qr
    if not command -v qrencode > /dev/null;
        echo "qrencode not found." 1>&2
        return 1
    end

    if [ "$XDG_SESSION_TYPE" = "wayland" ]
        if not command -v wl-paste > /dev/null 2>&1;
            echo "wl-paste not found. (Package wl-clipboard)" 1>&2
            return 1
        end
        if not command -v swayimg > dev/null 2>&1;
            echo "swayimg not found." 1>&2
            return 1
        end

        set clip_content "$(wl-paste)"
        set imgprog "swayimg"
    else
        if not command -v xclip > /dev/null 2>&1;
            echo "xlip not found." 1>&2
            return 1
        end
        if not command -v viewnior > /dev/null 2>&1;
            echo "viewnior not found." 1>&2
            return 1
        end

        set clip_content "$(xclip -o)"
        set imgprog "viewnior"
    end

    set qrfile "/tmp/qr.png"
    command qrencode -s 8 -o "$qrfile" "$clip_content"
    command "$imgprog" "$qrfile"
end
