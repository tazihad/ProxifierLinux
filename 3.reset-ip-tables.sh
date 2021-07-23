#!/bin/sh

iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X
killall redsocks
