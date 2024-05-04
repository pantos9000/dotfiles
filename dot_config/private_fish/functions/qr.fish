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

        set clip_content "$(wl-paste)"
    else
        if not command -v xclip > /dev/null 2>&1;
            echo "xlip not found." 1>&2
            return 1
        end

        set clip_content "$(xclip -o)"
    end

    command qrencode -s 8 -o -t utf8 "$clip_content"
end
