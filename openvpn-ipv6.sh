#!/bin/bash
# Quick  OpenVPN install script

ip=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
ipv6=`ifconfig |grep "inet6 addr"| cut -d " " -f13 | cut -d/ -f1| head -n 1`

apt-get install build-essential libssl-dev git-core

cd /tmp

wget http://www.oberhumer.com/opensource/lzo/download/lzo-2.04.tar.gz
tar zxf lzo-2.04.tar.gz 
cd lzo-2.04 && ./configure && make && make install
cd ..
git clone git@github.com:Tassandar/Openvpn-ipv6-patched.git
cd ./Openvpn-ipv6-patched && ./configure && make && make install
cd .. && cp -r ./openvpn-2.1.1/easy-rsa/ -r /etc/openvpn
cd /etc/openvpn/easy-rsa/2.0/
chmod +rwx *
. ../vars
./clean-all
source ./vars


echo -e "\n\n\n\n\n\n\n" | ./build-ca
clear
echo "####################################"
echo "Wouldn't recommend setting a password here"
echo "Then you'd have to type in the password each time openVPN starts/restarts"
echo "####################################"
./build-key-server server
./build-dh

cp keys/{ca.crt,ca.key,server.crt,server.key,dh1024.pem} /etc/openvpn/

clear
echo "####################################"
echo "Feel free to accept default values"
echo "This is your client key, you may set a password here but it's not required"
echo "####################################"

./build-key client1
 

client="
client
remote $ip 1194
dev tun
proto udp
resolv-retry infinite
persist-key
persist-tun
comp-lzo
ca ca.crt
cert client1.crt
key client1.key
redirect-gateway def1
dhcp-option DNS 10.3.1.1
verb 3
mute 20"

client6="
client
remote $ipv6 1196
dev tun
proto udp6
resolv-retry infinite
persist-key
persist-tun
comp-lzo
ca ca.crt
cert client1-ipv6.crt
key client1-ipv6.key
dhcp-option DNS 10.3.1.1
verb 3
mute 20"

./build-key client1-ipv6


cd keys/
echo "$client" > $HOSTNAME.ovpn
echo "$client6" > $HOSTNAME.ipv6.ovpn

tar czf keys.tgz ca.crt ca.key client1.crt client1.csr client1.key client1-ipv6.crt client1-ipv6.csr client1-ipv6.key  $HOSTNAME.ovpn

mv keys.tgz /tmp/

opvpn4='
dev tun
port 1194
proto udp
server 10.3.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
ca ca.crt
cert server.crt
key server.key
dh dh1024.pem
push "route 10.3.0.0 255.255.255.0" 
push "dhcp-option DNS 10.3.0.1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "redirect-gateway"
comp-lzo
keepalive 10 60
ping-timer-rem
persist-tun
persist-key
user nobody
group nobody
verb 3
daemon'

opvpn6='
dev tun
port 1196
proto udp6
server 10.3.1.0 255.255.255.0
ifconfig-pool-persist ipp6.txt
ca ca.crt
cert server.crt
key server.key
dh dh1024.pem
push "route 10.3.1.0 255.255.255.0" 
push "dhcp-option DNS 10.3.1.1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "redirect-gateway"
comp-lzo
keepalive 10 60
ping-timer-rem
persist-tun
persist-key
user nobody
group nobody
verb 3
daemon'

echo "$opvpn4" > /etc/openvpn/openvpn.conf
echo "$opvpn4" > /etc/openvpn/openvpn6.conf


sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.3.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.3.1.0/24 -o eth0 -j MASQUERADE

service iptables save
service iptables restart

echo "OpenVPN has been installed
Download /tmp/keys.tgz using winscp or other sftp/scp client such as filezilla 



