#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import time, sys, argparse
from socket import *

class CarbonAgent:
    def __init__(self, host, port, proto):
        self.data = []
        self.host = host
        self.port = port
        self.proto = proto

    def append(self, key, value, timestamp = None):
        if timestamp is None:
            timestamp = time.time()
        self.data.append('%s %s %d' % (key, value, int(timestamp)))

    def send(self):
        try:
            data = '\n'.join(self.data) + '\n'
            if self.proto == "TCP":
                sock = socket()
                sock.connect( (self.host,self.port) )
                sock.sendall(data)
            elif self.proto == "UDP":
                sock = socket(AF_INET,SOCK_DGRAM)
                sock.sendto( data, (self.host,self.port) )
            else:
                raise Exception("Unknown protocol!")
            sock.close()
            self.data = [] # clean data
        except Exception, err:
            print >> sys.stderr, err


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='carbonagent: send a value to graphite server')
    parser.add_argument('-H', help='graphite server address', required=True)
    parser.add_argument('-p', type=int, help='graphite server port', required=True)

    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--udp', action='store_true', help='UDP protocol')
    group.add_argument('--tcp', action='store_true', help='TCP protocol')

    args = parser.parse_args()

    if args.udp:
        proto = 'UDP'
    else:
        if args.tcp:
            proto = 'TCP'

    carbon = CarbonAgent(host=args.H, port=args.p, proto=proto)

    datalines = sys.stdin.readlines()
    for line in datalines:
        splitted = line.split(' ')
        key = splitted[0].strip()
        value = splitted[1].strip()
        if len(splitted) > 2:
            timestamp = splitted[2].strip()
        else:
            timestamp = None
        carbon.append(key, value, timestamp)

    carbon.send()
