# -*- coding: utf-8 -*-
"""
    netiodata

    Module to display the network io rate in MB.

    Configuration parameters:

        format: Display format
            (Default: '↥ {rate_up}MB ⤓ {rate_down}MB')

        cache_timeout: timeout to refresh
            (Default: 20)

        threshold_good: 
            (Default: 1)
        threshold_degraded: 
            (Default: 3)

    Format placeholders:
        rate_up: The overall upload rate
        rate_down: The overall download rate

    Color options:
        color_good: The sum of both rates is below threshold_good
        color_degraded: The sum of both rates is below threshold_degraded
        color_bad: The sum of both rates is above threshold_degraded

    Requires:
        python-psutil

"""


import psutil
from datetime import datetime


class Py3status:

    def __init__(self):
        self.format = '↥ {rate_up}MB ⤓ {rate_down}MB'
        self.cache_timeout = 20

        self.threshold_good = 1
        self.threshold_degraded = 3

        self._upload_old = 0
        self._download_old = 0
        self._time_old = None


    def _get_time_diff(self):
        time = datetime.now()
        if self._time_old == None:
            self._time_old = time
            return None
        diff = time - self._time_old
        self._time_old = time

        return diff.total_seconds()


    def _get_io_rate(self):
        io = psutil.net_io_counters()

        upload_new = io.bytes_sent
        upload_diff = upload_new - self._upload_old
        self._upload_old = upload_new

        download_new = io.bytes_recv
        download_diff = download_new - self._download_old
        self._download_old = download_new

        dtime = self._get_time_diff()
        if dtime == None:
            upload = 0
            download = 0
        else:
            upload = int(upload_diff/1024/1024/dtime)
            download = int(download_diff/1024/1024/dtime)

        return (upload, download)


    def ifdata(self):
        (rate_up, rate_down) = self._get_io_rate()

        replace = {
            'rate_up': rate_up,
            'rate_down': rate_down,
        }

        full_text = self.py3.safe_format(self.format, replace)
        cached_until = self.py3.time_in(self.cache_timeout)

        rate = rate_up + rate_down

        if rate < self.threshold_good:
            color = self.py3.COLOR_GOOD
        elif rate < self.threshold_degraded:
            color = self.py3.COLOR_DEGRADED
        else:
            color = self.py3.COLOR_BAD

        response = {
            'full_text': full_text,
            'cached_until': cached_until,
            'color': color,
        }
        return response

