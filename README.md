# Welcome to OpenWRT Tools Page
Here you will find tools and Information about OpenWRT.
I spend alot of time searching and finding solutions for my problems with OpenWRT. In this Repo i will post a couple of Solutions for some Main problems after installing openWRT on any Router-Hardware.


# Assign LAN Port To act as WAN
If you want to Route Traffic from another Router/Switch through your OpenWRT-Router, then assign a LAN Port of your router to act as WAN.
In the picture below you can see how the Configuration on OpenWRT needs to look like.

![alt text](https://github.com/kwget/openwrt-tools/blob/main/resources/vlan.png?raw=true)

* With this Setup let's say If you have a PPTP or OpenVPN on your OpenWRT all the Traffic from that VPN's Tunnel will go through your OpenWRT if you are connected as Client via LAN or WLAN because there are 2 possibilities. You change the Router to the Subnet of your ISP-Router and you are connected to that Route and VPN-Tunnels will have no effect even if you are connected as a client on your OpenWRT. Or you do the Setup like this if you use VPN or Not this method will work perfectly like this, because your OpenWRT-Router will use it's own Route and not the Route from your ISP-Router.

Standard-Setup: 
* Your OpenWRT act's like a Client because you will have only Internet on that box if you connect your Router on the Same Subnet like your ISP-Router.
```
OpenWRT-Router > ISP-Router > Internet
```
My Setup: 
* Will Route Traffic through your OpenWRT!
```
ISP-Router > OpenWRT-Router > Internet
```

How to do it? 
1. Login to LUCI on OpenWRT via the Webinterface go to: "Network > Switch" Configure the VLAN's like on my Image.
 
![alt text](https://github.com/kwget/openwrt-tools/blob/main/resources/vlan.png?raw=true)

2. Go to "Network > Interfaces" Edit "WAN" and Change Device to "eth0.2" and Protocol to "DHCP Client"
* Now the Interface will get Internet through your ISP's Router but will Route Traffic when you are connected on your OpenWRT through your OpenWRT Route. So if your OpenWRT is connected to an PPTP or OpenVPN Tunnel all the Traffic will go through that Route OUT to the Rest of the World.

* I have no Internet after this Setup? Easy just check Under your LAN or br-lan on "Network > Interfaces", Edit Settings go to Advanced Settings and add Custom DNS-Servers from Google or Cloudflare use 1.0.0.1 or 8.8.8.8 and it will work as long as your ISP's Router is connected to the Internet.

# Setup PPTP Client on OpenWRT
After you have installed a fresh openWRT on a nice Router you want to have a VPN Connection that is just nice.
First of all connect your LAN cables to your Router and make the Internet first working so the router is connected to the Internet first.
After you are done with that go to "Network > Diagnostics" and check if it is working do a ping on google.com if that works everything fine.

Now login to your OpenWRT box via SSH:
```
ssh root@192.168.1.1
```
Install the needed packages by typing the following commands:
```
opkg update
opkg install ppp-mod-pptp kmod-nf-nathelper-extra
```

Now go LUCI Webinterface then to "Network > Interfaces"
* Create new Interface click on "Add new interface" 
```
Name: vpn
Procotol: PPP (because after 20.1 PPtP is not shown but we will fix this via a command)
```
* Then Click on "Create Interface".
* After that Edit the fresh Created Interface and Assign Firewall Zone "WAN" so you dont have to play with the Rules more safe like this for beginners.

Now let's make the Setup Perfect!

* Switch back to your SSH-Terminal and type in the following Commands:

```
uci set network.vpn=interface
uci set network.vpn.username='USERNAME'
uci set network.vpn.password='PASSWORD'
uci set network.vpn.ipv6='auto'
uci set network.vpn.proto='pptp'
uci set network.vpn.server='SERVER-IP'
uci commit
```
* Then restart your network.
```
/etc/init.d/network restart
```
* Connect back to your Network if you are via WLAN.
* Done.

# I want to USE only VPN-Traffic if the Connection of the VPN is lost i dont want that my ISP's Connection is used on this router without a VPN.
Very clear, if we lose the VPN Connection and we still want to stay Anonymous then we have to do this changes on the OpenWRT.
1. Login to your OpenWRT-Routers Webinterace
2. Go to: Network > Firewall
3. Edit your "lan" zone
4. Remove "wan or any wans" from "Allow forward to destination zones:" let only your VPN and LAN to forward traffic all others not allowed.
5. Done.

This method will ensure that only if your PPTP/VPN/OpenVPN Tunnel is connected you can Surf the Internet if not there will not go a point of Information out to the Internet so we are safe to Surf and we can sleep better.
* Local Connections are still allowed, so you can connect to your ISP-Routers local Admin Page and things but you are sure with this that your Real-IP not goes out if you use your OpenWRT as a TunnelBox.
