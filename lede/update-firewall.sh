#!/bin/sh

# one-off script to update openvpn config of running openwrt/lede router
# to match commit f77f54d4b1d02e89ac4af25620bc382386f0dd96

# look for config stanza handle associated with firewall zone
cfg=$(uci -X show firewall | grep 'network' | grep 'vpn' | cut -d. -f2)

# change vpn zone forward policy to ACCEPT
uci set firewall.$cfg.forward=ACCEPT

# look for config stanza handle associated with firewall forwarding rules
cfg=$(uci -X show firewall | grep src | grep vpn | cut -d. -f2)

# if it doesn't exist, create one to allow vpn-to-lan traffic
if [ -z "$cfg" ] ; then
	uci add firewall forwarding
	uci set firewall.@forwarding[-1].dest=lan
	uci set firewall.@forwarding[-1].src=vpn
fi

uci commit firewall

/etc/init.d/firewall restart
