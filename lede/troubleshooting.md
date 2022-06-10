# Serial connection

With the LEDs facing you and the ethernet ports away from you, UART is
on the right side, with a four pin header.  Don't connect the Red wire
(it's 5V, the pin is VCC, only 3.3V).

The connections are:

    ETHERNET
    NoConnect
    White
    Green
    Black
    LEDS
        
On a linux machine, you can plug in the USB-serial adapter to a USB
port, you should get a /dev/ttyUSBn, where n is probably zero (i.e.
/dev/ttyUSB0). You can use screen for the terminal emulator:

    $ screen /dev/ttyUSB0 115200

You might have a permissions problem on the tty device, you might need
to add yourself to the associated group (on Ubuntu, the group is
"dialout"). Or, if you are lazy, you can use sudo or become root.

# Recovery without SSH

Recovery requires setting up a TFTP server and
hosting a stripped down image to flash, and then sysupgrade from it.
The WGT634U uses kind of a stupid idiosyncratic bootloader (a version
of CFE). Most modern devices are using u-boot and are generally better
behaved. The CFE bootloader on the WGT634U has a size limit of a
little under 4MB, which you can work around by doing two TFTP's, but
it's even more awkward than flashing twice, once from TFTP and then
sysupgrade.

# sysupgrade firmware

https://lede-project.org/docs/user-guide/sysupgrade.cli
https://lede-project.org/docs/guide-quick-start/sysupgrade.luci

# manual openvpn install

opkg update
opkg install openvpn-openssl luci-app-openvpn
create new openvpn instance by uploading conf
upload creds to location referenced by conf

# Log and status
logread -f
logread -e openvpn
netstat -l -n -p | grep -e openvpn
