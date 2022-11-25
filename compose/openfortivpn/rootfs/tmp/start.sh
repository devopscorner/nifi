#!/bin/sh

export VAR_HOST="${VPN_HOST}"
export VAR_PORT="${VPN_PORT}"
export VAR_USER="${VPN_USER}"
export VAR_PASS="${VPN_PASS}"
export VAR_TRUST_CERT="${VPN_TRUST_CERT}"

if [ ! -f "/tmp/openfortivpn.conf" ]; then
    cat /tmp/openfortivpn.tpl | envsubst > /tmp/openfortivpn.conf
fi

if [ -z "${VPN_HOST}" -o -z "${VPN_PORT}" -o -z "${VPN_USER}" -o -z "${VPN_PASS}" -o -z "${VPN_TRUST_CERT}" ]; then
    echo "Variables VPN_HOST, VPN_PORT, VPN_USER, VPN_PASS and VPN_TRUST_CERT must be set."
    exit
fi

if [ ! -d "/dev/ppp" ]; then
    echo pppoe > /etc/modules
    mknod /dev/ppp c 108 0
fi

export VPN_TIMEOUT=${VPN_TIMEOUT:-5}

# Setup masquerade, to allow using the container as a gateway
for iface in $(ip a | grep eth | grep inet | awk '{print $2}'); do
    iptables -t nat -A POSTROUTING -s "$iface" -j MASQUERADE
done

while [ true ]; do
    echo "------------ VPN Starts ------------"
    /usr/bin/openfortivpn -c /tmp/openfortivpn.conf > /var/log/openfortivpn.log
    echo "------------ VPN Exited ------------"
    sleep 10
done
