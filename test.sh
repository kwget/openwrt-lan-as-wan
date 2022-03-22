#!/bin/sh

########################################################################
# Start SSH Tunnel
######################################################################

 

if [ $(netstat -an | grep 1337 | wc -c) -ne 0 ]

 

then
echo “ssh tunnel is connected, exiting …”
exit

 

else

 

echo “connecting to dnsflex ssh Tunnel”
ssh -N -i /root/.ssh/id_rsa -L 1337:192.168.1.1:22 root@172.104.132.218 -f
fi

#######################################################################
# Start Redsocks
#######################################################################

 

echo “starting Redsocks”
redsocks -c /tmp/ssh_tunnel/redsocks.conf -p /dev/null

 

########################################################################
# IPtables setup
########################################################################

 

echo “starting IPtables rules”

 
# create the REDSOCKS target
iptables -t nat -N REDSOCKS

 
# don’t route unroutable addresses
iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

 

# redirect statement sends everything else to the redsocks
# proxy input port
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 1338

 

# if it came in on eth0, and it is tcp, send it to REDSOCKS
iptables -t nat -A PREROUTING -i br-lan -p tcp -j REDSOCKS

 

# Use this one instead of the above if you want to proxy the local
# networking in addition to the subnet stuff. Redsocks listens on
# all interfaces with local_ip = 0.0.0.0 so no other changes are
# necessary.
#iptables -t nat -A PREROUTING -p tcp -j REDSOCKS

 
# don’t forget to accept the tcp packets from eth0
iptables -A INPUT -i br-lan -p tcp --dport 1338 -j ACCEPT
