#!/usr/bin/env python

# (c) 2013, Greg Buehler
#
# This file is part of Ansible,
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

######################################################################

"""
Zabbix Server external inventory script. 
========================================

Returns hosts and hostgroups from Zabbix Server.

Configuration is read from `zabbix.ini`.

Tested with Zabbix Server 2.0.6.
"""

import os, sys
import json
import argparse
import ConfigParser

try:
    from zabbix_api import ZabbixAPI
except:
    print >> sys.stderr, "Error: Zabbix API library must be installed: pip install zabbix-api."
    sys.exit(1)

try:
    import json
except:
    import simplejson as json

class ZabbixInventory(object):

    def read_settings(self):
        config = ConfigParser.SafeConfigParser()
        config.read(os.path.dirname(os.path.realpath(__file__)) + '/zabbix.ini')
        # server
        if config.has_option('zabbix', 'server'):
            self.zabbix_server = config.get('zabbix', 'server')

        # login   
        if config.has_option('zabbix', 'username'):
            self.zabbix_username = config.get('zabbix', 'username')
        if config.has_option('zabbix', 'password'):
            self.zabbix_password = config.get('zabbix', 'password')

    def read_cli(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--host')
        parser.add_argument('--list', action='store_true')
        self.options = parser.parse_args()

    def hoststub(self):
        return {
            'hosts': []
        }

    def get_host(self, api, name):
        data = {}
        return data

    def get_list(self, api):
        hostsData = api.host.get({'output': 'extend', 'selectGroups': 'extend'})

        data = {}
        data[self.defaultgroup] = self.hoststub()

        for host in hostsData:
            hostname = host['name']
            data[self.defaultgroup]['hosts'].append(hostname)   

            for group in host['groups']:
                groupname = group['name']

                if not groupname in data:
                    data[groupname] = self.hoststub()

                data[groupname]['hosts'].append(hostname)

        return data

    def __init__(self):

        self.defaultgroup = 'group_all'
        self.zabbix_server = None
        self.zabbix_username = None
        self.zabbix_password = None

        self.read_settings()
        self.read_cli()

        if self.zabbix_server and self.zabbix_username:
            try:
                api = ZabbixAPI(server=self.zabbix_server)
                api.login(user=self.zabbix_username, password=self.zabbix_password)
            except BaseException, e:
                print >> sys.stderr, "Error: Could not login to Zabbix server. Check your zabbix.ini."
                sys.exit(1)

            if self.options.host:
                data = self.get_host(api, self.options.host)
                print json.dumps(data, indent=2)

            elif self.options.list:
                data = self.get_list(api)
                print json.dumps(data, indent=2)

            else:
                print >> sys.stderr, "usage: --list  ..OR.. --host <hostname>"
                sys.exit(1)

        else:
            print >> sys.stderr, "Error: Configuration of server and credentials are required. See zabbix.ini."
            sys.exit(1)

ZabbixInventory()
