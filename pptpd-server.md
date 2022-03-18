# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# configure firewall
iptables -t nat -A POSTROUTING -s 10.99.99.0/24 ! -d 10.99.99.0/24 -j MASQUERADE
iptables -A FORWARD -s 10.99.99.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356
iptables -A INPUT -i ppp+ -j ACCEPT
iptables -A OUTPUT -o ppp+ -j ACCEPT
iptables -A FORWARD -i ppp+ -j ACCEPT
iptables -A FORWARD -o ppp+ -j ACCEPT

FILE: #### pptpd.conf
option /etc/ppp/pptpd-options
#debug
#stimeout 10
logwtmp
#bcrelay eth1
#delegate
#connections 100
localip 10.99.99.1


FILE: #### /etc/ppp/pptpd-options
name pptpd
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
require-mppe-128

# Network and Routing
ms-dns 8.8.8.8
ms-dns 8.8.4.4
proxyarp
nodefaultroute

# Logging
# debug
# dump

# Miscellaneous
lock
nobsdcomp
novj
novjccomp
nologfd


