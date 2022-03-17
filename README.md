# Welcome to OpenWRT Tools Page
Here you will find tools and Information about OpenWRT.
I spend alot of time searching and finding solutions for my problems with OpenWRT. In this Repo i will post a couple of Solutions for some Main problems after installing openWRT on any Router-Hardware.


# Assign LAN Port To act as WAN
If you want to Route Traffic from another Router/Switch through your OpenWRT-Router, then assign a LAN Port of your router to act as WAN.
In the picture below you can see how the Configuration on OpenWRT needs to look like.

* With this method if you have a PPTP or OpenVPN on your OpenWRT all the Traffic from that VPN's Tunnel will work if you are connected as Client via LAN or WLAN because there are 2 possibilities. You change the Router to the Subnet of your ISP-Router and you are connected to that Route and VPN-Tunnels will have no effect if you are connected as a client on your OpenWRT. Or you do the Setup like this if you use VPN or Not this method will work perfectly like this.

![alt text](https://github.com/kwget/openwrt-tools/blob/main/resources/vlan.png?raw=true)

How to do it? 
1. Login to LUCI on OpenWRT go to: "Network > Switch" Configure the VLAN's like on my Image.
2. Go to "Network > Interfaces" Edit "WAN" and Change Device to "eth0.2" and Protocol to "DHCP Client"
* Now the Interface will get Internet through your ISP's Router but will Route Traffic when you are connected on your OpenWRT through your OpenWRT Route. So if your OpenWRT is connected to an PPTP or OpenVPN Tunnel all the Traffic will go through that Route OUT to the Rest of the World.

* I have no Internet after this Setup? Easy just check Under your LAN or br-lan on "Network > Interfaces", Edit Settings go to Advanced Settings and add Custom DNS-Servers from Google or Cloudflare use 1.0.0.1 or 8.8.8.8 and it will work as long as your ISP's Router is connected to the Internet.

# Setup PPTP Client on OpenWRT
After you have installed a fresh openWRT on a nice Router you want to have a VPN Connection that is just nice.
First of all connect your LAN cables to your Router and make the Internet first working so the router is connected to the Internet first.
After you are done with that go to "Network > Diagnostics" and check if it is working do a ping on google.com if that works everything fine.

Now login to your OpenWRT box via SSH:
* ssh root@192.168.1.1
* opkg update
* opkg install ppp-mod-pptp kmod-nf-nathelper-extra

Now go LUCI Webinterface then to "Network > Interfaces"
* Create new Interface click on "Add new interface" 
* Name: vpn
* Procotol: PPP (because after 20.1 PPtP is not shown but we will fix this via a command)
* Then Click on "Create Interface"

* Now back to your SSH and type in the following Commands:
* uci set network.vpn=interface
* uci set network.vpn.username='USERNAME'
* uci set network.vpn.password='PASSWORD'
* uci set network.vpn.ipv6='auto'
* uci set network.vpn.proto='pptp'
* uci set network.vpn.server='SERVER-IP'
* uci commit
* Then restart your network.
* /etc/init.d/network restart
* Connect back to your Network if you are via WLAN.
* Done.