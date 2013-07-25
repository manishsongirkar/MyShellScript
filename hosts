#!/bin/bash
# Save this file in bin/hosts
# This code Developed by @manishsongirkar

DEFAULT_IP=127.0.0.1
add_remove=$1
host_name=$2
IP_add=$3

usage ()
{
  echo "Usage: bash bin/hosts [add|remove] [hostname] [ip]" >&2

  echo "       Ip defaults to 127.0.0.1" >&2

  echo "       bash bin/hosts add testing.com" >&2

  echo "       bash bin/hosts remove testing.com 192.168.1.1" >&2
}


if [ -z "$add_remove" ]; then
  usage
elif [ "$add_remove" != "add" ] && [ "$add_remove" != "remove" ]; then
	echo "add_remove parameter must be 'add' or 'remove'!" >&2
	usage
fi


if [ -z "$host_name" ]; then
	echo "Hostname must be your domain name without http!" >&2
fi


if [ -z "$IP_add" ]; then
	IP_add=${3:-$DEFAULT_IP}
fi


if [ "$add_remove" == "add" ] && [ "$host_name" != "" ]; then
	if grep -w -q $IP_add /etc/hosts; then
		sudo sed -i 's/\<'$IP_add'\>/'$IP_add' '$host_name' /g' /etc/hosts
	else 
		sudo echo "$IP_add $host_name" >> /etc/hosts
	fi
fi

if [ "$add_remove" == "remove" ] && [ "$host_name" != "" ]; then
	sudo sed -ie 's/'$host_name'/ /g' /etc/hosts
fi

exit 0
