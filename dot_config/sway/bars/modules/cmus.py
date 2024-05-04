# -*- coding: utf-8 -*-
"""
    cmus

    Display now playing information from cmus.

    Configuration parameters:

        format: Display format
            (Default: '♫ {artist} - {title}')

        off_format: Display format if cmus is not running
            (Default: '♫ (cmus not running)')

        cache_timeout: Timeout to refresh
            (Default: 10)

    Format placeolders:
        artist: Song artist
        title: Song title

    Color options:
        color_good: cmus is running
        color_bad: no running cmus instance is found

"""


import subprocess


class Py3status:

    def __init__(self):
        self.cache_timeout = 10
        self.format = '♫ {artist} - {title}'
        self.off_format = '♫ (cmus not running)'


    def _get_cmus_info(self):
        cmus_remote_pipe = subprocess.Popen(["cmus-remote", "-Q"], stdout = subprocess.PIPE, stderr = subprocess.PIPE)
        cmus_info_text = cmus_remote_pipe.communicate()[0].decode()

        if cmus_info_text == "":
            return {}

        cmus_info = {
            "tags": {}
        };
    
        for line in cmus_info_text.splitlines():
            entry = line.split(None, 2)
            
            if entry[0] == "tag" and len(entry) > 2:
                cmus_info["tags"][entry[1]] = entry[2]
            elif len(entry) > 1:
                cmus_info[entry[0]] = entry[1]
    
        return cmus_info


    def cmus(self, i3s_output_list, i3s_config):
        cmus_info = self._get_cmus_info();

        if "status" in cmus_info:
            if "artist" in cmus_info["tags"]:
                artist = cmus_info["tags"]["artist"]
            else:
                artist = "?"

            if "title" in cmus_info["tags"]:
                title = cmus_info["tags"]["title"]
            else:
                title = "?"
            cmus_playing = True
        else:
            artist = '?'
            title = '?'
            cmus_playing = False

        replace = {
            'artist': artist,
            'title': title,
        }

        if cmus_playing:
            full_text = self.py3.safe_format(self.format, replace)
            color = self.py3.COLOR_GOOD
        else:
            full_text = self.py3.safe_format(self.off_format, replace)
            color = self.py3.COLOR_BAD
        cached_until = self.py3.time_in(self.cache_timeout)

        response = {
            'full_text': full_text,
            'cached_until': cached_until,
            'color': color,
        }

        return response


if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    from time import sleep
    x = Py3status()
    while True:
        print(x.cmus([], {}))
        sleep(1)

