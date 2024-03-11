# Hotspot-script

One of the possible methods to deploy your hotspot with minimal resource usage. 
Required stack: 
- hostapd
- dnsmasq
- iptables

To start without configuration, simply execute a series of commands (with sudo only):
```
git clone https://github.com/n3170n/Hotspot-script.git
cd Hotspot-script
sudo chmod +x hotspot.sh
sudo ./hotspot.sh
```

To terminate the hotspot, press ctrl+C, and the application will automatically begin the configuration rollback process.

## Configuration options available: 
- **hostapd.conf**
  - Hotspot name configuration
  - Hotspot password
- **dnsmasq.conf**
  - DHCP address pool configuration
  - Setting DNS address
- **hotspot.sh**
  - Configuration of necessary interfaces
