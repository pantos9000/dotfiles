# -*- coding: utf-8 -*-
"""
    ifdata

    Module to display the ip address via python-netifaces.

    Configuration parameters:

        format: Display format
            (Default: '{nic}: {ip4}')

        nic: Network interface
            (Default: 'eth0')

        cache_timeout: timeout to refresh
            (Default: 60)

    Format placeholders:
        nic: The given network device
        ip4: The IPv4 address
        ip6: The IPv6 address

    Color options:
        color_good: IPv4 and IPv6 addresses are both available
        color_degraded: Only one address is available
        color_bad: No address is available

    Requires:
        python-netifaces

TODO: click: toggle ipv4/6

"""


import netifaces


class Py3status:

    def __init__(self):
        self.format = '{nic}: {ip4}'
        self.cache_timeout = 60
        self.nic = 'eth0'


    def _get_ip_from_addr_list(self, addr_list, index):
        ip = 'down'

        if index in addr_list:
            addr = addr_list[index]
            ip = addr[0]['addr']
            for i in addr[1:]:
                ip += ', '+ i['addr']

        return ip


    def _get_ips(self):
        if_list = netifaces.interfaces()
        if self.nic not in if_list:
            return ('down', 'down')

        addr_list = netifaces.ifaddresses(self.nic)
        ip4_index = netifaces.AF_INET
        ip6_index = netifaces.AF_INET6

        ip4 = self._get_ip_from_addr_list(addr_list, ip4_index)
        ip6 = self._get_ip_from_addr_list(addr_list, ip6_index)

        return (ip4, ip6)


    def ifdata(self):
        (ip4, ip6) = self._get_ips()

        replace = {
            'nic': self.nic,
            'ip4': ip4,
            'ip6': ip6,
        }

        full_text = self.py3.safe_format(self.format, replace)
        cached_until = self.py3.time_in(self.cache_timeout)

        if ip4 == 'down' and ip6 == 'down':
            color = self.py3.COLOR_BAD
        elif ip4 == 'down' or ip6 == 'down':
            color = self.py3.COLOR_DEGRADED
        else:
            color = self.py3.COLOR_GOOD

        response = {
            'full_text': full_text,
            'cached_until': cached_until,
            'color': color,
        }
        return response

