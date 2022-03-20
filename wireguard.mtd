# macOS PFCTL Rules for Wireguard

Crete file if not exists
```
nano /usr/local/etc/pf-nat.conf
```
-- /usr/local/etc/pf-nat.conf
```
nat on en0 from 10.0.0.0/24 to any -> (en0)
nat on en0 from 10.0.0.4/32 to any -> (en0)
nat on utun4 from 10.0.0.0/24 to any -> (utun4)
nat on utun4 from 10.0.0.4/32 to any -> (utun4)

#pass in quick on egress inet proto udp to port utun4

pass in on egress proto udp from any to any port 51820

#match out on egress from utun4:network nat-to egress

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
