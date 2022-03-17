# Setup OpenVPN Tunnel on openWRT
* Make sure your OpenWRT Box has Internet before doing all this.

1.Login to your Box via SSH Terminal
```
opkg update
opkg install openvpn-openssl luci-app-openvpn
```

Type in first Line your Username
2th Line your Password
Like this.

````
cat > /etc/openvpn/auth.txt << EOF
user@mail.com
password
EOF
````

Go to your Webinterface under VPN > OpenVPN

1. Upload any .ovpn Profile
2. Edit that Profile
3. Replace "auth-user-pass" with "auth-user-pass /etc/openvpn/auth.txt"
4. Replace "dev" with "dev tun0"
5. Save.

Go to your Webinterface under Network > Interfaces

1. Create and Unmanaged Interface with a Custom Name "tun0"
2. Assign Firewall Zone "WAN" on that Interface to not have Firewall conflicts.

Go to your Webinterface under VPN > OpenVPN
1. Enable your Configured Profile
2. Done.

# Checking openWRT Logs!
To check the logs, Login to your SSH and type in: "logread"
* On openwrt there are no log files stored, it can only be read from the memory. So don't be confused.


# VPN-Policy Routing: If you want to Have Custom Control over Clients Traffic
* install "VPN-Policy Routing" with that you can Route a specific IPv4 Connected Client via an Interface what you like.

As Sample you want Client with IP 192.168.1.10 to go Through VPN Interface
Or you want that Client with IP 192.168.1.11 to go Through WAN Interface.

To install VPN-Routing-Policy.

1.Login to your Box via SSH Terminal
```
opkg update
opkg install vpn-policy-routing luci-app-vpn-policy-routing
opkg remove dnsmasq
opkg install dnsmasq-full
```
2. Go to your Webinterface under VPN > VPN Policy Routing

Under the Section "Policies" you can specify your Rules what you like.
