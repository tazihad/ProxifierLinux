#!/bin/sh

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi


# start redsocks
redsocks -c /etc/redsocks.conf


# Create new chain
iptables -t nat -N REDSOCKS

# Ignore LANs and some other reserved addresses.
iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

# Anything else should be redirected to port 12345
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345

# Redirect all HTTP and HTTPS outgoing packets through Redsocks
iptables -t nat -A OUTPUT -p tcp --dport 443 -j REDSOCKS
iptables -t nat -A OUTPUT -p tcp --dport 80 -j REDSOCKS

# Defining the following rules in the PREROUTING chain. For redirecting incomming packets to the REDSOCKS chain.
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDSOCKS
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDSOCKS

