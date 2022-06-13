#!/bin/sh

# one-off script to update openvpn config of running openwrt/lede router
# to match current config

rm /etc/config/openvpn
touch /etc/config/openvpn

uci batch <<EOF

add openvpn openvpn
set openvpn.@openvpn[-1].enabled=1
set openvpn.@openvpn[-1].client='1'
set openvpn.@openvpn[-1].dev='tun'
add_list openvpn.@openvpn[-1].remote='vpnbox-prod-foo.phu73l.net 1194 udp'
add_list openvpn.@openvpn[-1].remote='vpnbox-prod-bar.phu73l.net 1194 udp'
add_list openvpn.@openvpn[-1].remote='vpnbox-prod-baz.phu73l.net 1194 udp'
add_list openvpn.@openvpn[-1].remote='vpnbox-prod-foo.phu73l.net 1194 tcp'
add_list openvpn.@openvpn[-1].remote='vpnbox-prod-bar.phu73l.net 1194 tcp'
add_list openvpn.@openvpn[-1].remote='vpnbox-prod-baz.phu73l.net 1194 tcp'
set openvpn.@openvpn[-1].resolve_retry='infinite'
set openvpn.@openvpn[-1].nobind='1'
set openvpn.@openvpn[-1].persist_key='1'
set openvpn.@openvpn[-1].persist_tun='0'
set openvpn.@openvpn[-1].keepalive='10 120'
set openvpn.@openvpn[-1].remote_cert_tls=server
set openvpn.@openvpn[-1].ca='/etc/openvpn/keys/ca.crt'
set openvpn.@openvpn[-1].cert='/etc/openvpn/keys/client.crt'
set openvpn.@openvpn[-1].key='/etc/openvpn/keys/client.key'
set openvpn.@openvpn[-1].compress='lzo'

commit openvpn

EOF

/etc/init.d/openvpn restart

