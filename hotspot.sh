#!/bin/bash

interrupt_handler(){
    kill $hostapd_pid $dnsmasq_pid
    echo "0" > /proc/sys/net/ipv4/ip_forward
    iptables-restore < iptables-rules
    rm -f iptables-rules
    ip addr flush dev wlan0
    ip link set wlan0 down
    exit 0
}

trap interrupt_handler SIGINT

# Copy iptables
iptables-save > iptables-rules

# Configure frowardings and interfaces
echo "1" > /proc/sys/net/ipv4/ip_forward
ip link set wlan0 up
ip addr add 192.168.24.1/24 dev wlan0

# Adding iptable's rules
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o wlan0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

dnsmasq -C dnsmasq.conf
dnsmasq_pid=$(pgrep -u nobody dnsmasq)
hostapd hostapd.conf &
hostapd_pid=$!

echo -e "Hostapds PID: "$hostapd_pid"\nDnsmasq PID: "$dnsmasq_pid"\n"
wait $hostapd_pid
