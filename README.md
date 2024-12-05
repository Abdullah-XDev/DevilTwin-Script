# DevilTwin Script

This script automates the process of creating a **Fake Access Point (DevilTwin Attack)** using Kali Linux or a similar penetration testing distribution.

## Features
- **Wi-Fi Adapter Selection:** Lists all available Wi-Fi adapters for easy selection.
- **Network Scanning:** Scans for nearby Wi-Fi networks and displays details (SSID, Channel, Signal, etc.).
- **SSID Cloning:** Allows the user to select a target network (SSID) to clone.
- **Fake Access Point Creation:** Sets up a fake access point using `hostapd` and `dnsmasq`.

## Prerequisites
Make sure you have the following installed:
- **Operating System:** Kali Linux or any Linux distribution with wireless tools support.
- **Required Tools:**
  - `aircrack-ng`
  - `dnsmasq`
  - `hostapd`
- **Root Access:** You must run the script with root privileges.

## Install Tools (If Not Installed)
Use the following commands to install the tools on Debian-based systems:
 `sudo apt update`
 `udo apt install aircrack-ng dnsmasq hostapd -y`

## Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/Abdullah-XDev/DevilTwin-Script.git
   
## Steps:
1. cd
    ```bash
    cd DevilTwin-Script
      
4. Make the script executable:
    ```bash
    chmod +x deviltwin.sh
      
6. Run the script as root:
    ```bash
    sudo ./deviltwin.sh
   
## Disclaimer
This script is for educational purposes only. Unauthorized use against networks you do not own or have explicit permission to test is illegal. Use responsibly and within the confines of the law.
