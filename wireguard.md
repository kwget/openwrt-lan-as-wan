# macOS PFCTL Rules for Wireguard (Serverside)

Crete file if not exists
```
nano /usr/local/etc/pf-nat.conf
```
-- /usr/local/etc/pf-nat.conf
```
nat on en0 from 10.0.0.0/24 to any -> (en0)
nat on en0 from 10.0.0.4/32 to any -> (en0)

pass in on egress proto udp from any to any port 51820
pass on utun4 keep state (if-bound)
pass out on egress proto {tcp,udp,icmp}
pass out on utun4 all
pass out on utun4 proto {tcp, udp} from any to YOUR-PUBLIC-SERVER-IP
```

```
sudo pfctl -d
sudo sysctl -w net.inet.ip.forwarding=1
sudo pfctl -f /usr/local/etc/pf-nat.conf -e
```

# Install WireGuard on OpenWRT (ClientSide)
opkg update
opkg install wireguard-tools kmod-wireguard luci-app-wireguard luci-i18n-wireguard-en luci-proto-wireguard  kmod-nf-nathelper-extra
echo 'net.netfilter.nf_conntrack_helper=1' >> /etc/sysctl.d/11-nf-conntrack.conf
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.d/11-nf-conntrack.conf

/etc/init.d/sysctl restart
/etc/init.d/network restart

# Generate Wireguard Ready to use Configs
https://www.wireguardconfig.com/

