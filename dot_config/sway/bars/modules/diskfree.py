# -*- coding: utf-8 -*-
"""
    diskfree

    Module to display free space via 'df -h <location>'.

    Configuration parameters:

        format: Display format
            (Default: '{avail_percent} free')

        location: location 
            (Default: '/')

        check_filesystem: Check if mountpoint uses this filesystem
            (Default: None)

        check_format: 

        cache_timeout: timeout to refresh
            (Default: 60)

        threshold_good: free percentage above which free space is considered good
            (Default: 15)
        threshold_degraded: free percentage above which free space is considered degraded
            (Default: 5)

    Format placeholders:
        size: Absolute size of the partition
        used: Absolute amount of space used 
        avail: Absolute amount of free space
        used_percent: Relative amount of used space
        avail_percent: Relative amount of free space

    Color options:
        color_good: Amount of (relative) free space is above threshold_good
        color_degraded: Amount of (relative) free space is below threshold_degraded
        color_bad: Amount of (relative) free space is below threshold_bad


        TODO:
            onclick: dunst df -h output

"""


class Py3status:

    def __init__(self):
        self.format = '{avail_percent} free'
        self.location = '/'
        self.check_filesystem = None
        self.cache_timeout = 60

        self.size = '?'
        self.used = '?'
        self.avail = '?'
        self.used_percent = '?'
        self.avail_percent = '?'
        self.free = 0

        self.threshold_good = 15
        self.threshold_degraded = 5


    def _get_data(self, loc):
        try:
            result = self.py3.command_output('df -h {}'.format(loc))
            line2 = result.split('\n')[1]
            output = line2.split()

            self.size = output[1]
            self.used = output[2]
            self.avail = output[3]
            self.used_percent = output[4]
            self.avail_percent = '{}%'.format(100-int(self.used_percent[:-1]))
            self.free = int(self.avail_percent[:-1])
        except:
            self.size = '?'
            self.used = '?'
            self.avail = '?'
            self.used_percent = '?'
            self.avail_percent = '?'
            self.free = 0


    def diskfree(self):
        self._get_data(self.location)

        replace = {
            'size': self.size,
            'used': self.used,
            'avail': self.avail,
            'used_percent': self.used_percent,
            'avail_percent': self.avail_percent,
        }

        full_text = self.py3.safe_format(self.format, replace)
        cached_until = self.py3.time_in(self.cache_timeout)

        if self.free > self.threshold_good:
            color = self.py3.COLOR_GOOD
        elif self.free > self.threshold_degraded:
            color = self.py3.COLOR_DEGRADED
        else:
            color = self.py3.COLOR_GOOD

        response = {
            'full_text': full_text,
            'cached_until': cached_until,
            'color': color,
        }
        return response

