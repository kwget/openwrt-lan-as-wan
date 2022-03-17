# Flash Routers Tools
Here a bunch of tools used for Flashing Routers.

* If you want to Flash any AVM-Fritzbox use "fritzflash.py" from the Resources folder.
1. Change your LAN IPv4 to 192.168.178.2 / Subnet 255.255.255.0 / Gateway: 192.168.178.1
2. Connect a LAN Cable to your Fritzbox and use fritzflash.py the parameters are easy just type in --help after.

# macOS Tools for Flashing openWRT
* If you want to Flash other Routers TP-Link, ASUS, D-Link..

Under the Resources folder you will find nice tools for Flashing Routers
1. TFTP Server App (an easy App to work with)
2. Serial Tools App (to read from UART Serial Console) for that you will need some Hardware an USB to Serial/UART Adapter.
3. PL2303 Drivers for macOS Big Sur / Monterey

4. Search and Buy an Adapter with the PL2303 Chip: "USB to Serial PL2303"
Looks like this:
![alt text](https://github.com/kwget/openwrt-tools/blob/main/resources/DEBO_USB_2_UART_01.jpeg?raw=true)

# How to Read the Serial/UART via USB under macOS BigSur/Monterey.
* With this tools i Flashed Routers with OpenWRT-Images under macOS etc.

1. Install PL2303 Drivers on your MAC, you can find them on my Resources folder.
2. Put in the USB Adapter PL2303 on your USB Port on your macOS
3. Connect your RX, TX, GND points to your Router
4. Open "Serial Tools App" and choose Serial Port: "usbserial-11230"
5. Connect!
6. Power on your Router and you are Connected!

# TFTP-Server under macOS
1. Use the app on the Resources folder. It's so easy to Use if you need it on any Flashing Process.
