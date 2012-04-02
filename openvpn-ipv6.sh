#!/bin/bash
# Quick  OpenVPN install script

ip=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
ipv6=`ifconfig |grep "inet6 addr"| cut -d " " -f13 | cut -d/ -f1| head -n 1`

apt-get install build-essential libssl-dev git-core
addgroup nobody
cd /tmp

wget http://www.oberhumer.com/opensource/lzo/download/lzo-2.04.tar.gz
tar zxf lzo-2.04.tar.gz 
cd lzo-2.04 && ./configure && make && make install
cd ..
git clone  https://Tassandar@github.com/Tassandar/Openvpn-ipv6-patched.git
cd ./Openvpn-ipv6-patched && ./configure && make && make install
cp -r ./easy-rsa/* -r /etc/openvpn
cd /etc/openvpn/2.0/
chmod +rwx *
. ./vars
./clean-all
source ./vars


echo -e "\n\n\n\n\n\n\n" | ./build-ca
clear
echo "####################################"
echo "Wouldn't recommend setting a password here"
echo "Then you'd have to type in the password each time openVPN starts/restarts"
echo "####################################"
./build-key-server server
clear
echo "####################################"
echo "Feel free to accept default values"
echo "This is your client key, you may set a password here but it's not required"
echo "####################################"

./build-key client1 

./build-dh
 

client="
client
remote $ip 8888
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
remote $ipv6 9999
dev tun
proto udp6
resolv-retry infinite
persist-key
persist-tun
comp-lzo
ca ca.crt
cert client1.crt
key client1.key
dhcp-option DNS 10.3.1.1
verb 3
mute 20"


cd keys/
echo "$client" > $HOSTNAME.ovpn
echo "$client6" > $HOSTNAME.ipv6.ovpn

cp ./{ca.crt,ca.key,server*.crt,server*.key,dh1024.pem} /etc/openvpn/
tar czf keys.tgz ca.crt ca.key client*.crt client*.csr client*.key  $HOSTNAME*.ovpn 
mv keys.tgz /root/

mkdir /etc/openvpn/2.0/conf

opvpn4="local $ip
port 8888
proto udp
dev tun
ca /etc/openvpn/2.0/keys/ca.crt
cert /etc/openvpn/2.0/keys/server.crt
key /etc/openvpn/2.0/keys/server.key  # This file should be kept secret
dh /etc/openvpn/2.0/keys/dh1024.pem
server 10.3.0.0 255.255.255.0
ifconfig-pool-persist /etc/openvpn/ipp-udp.txt
push \"redirect-gateway def1 bypass-dhcp\"
push \"dhcp-option DNS 10.3.0.1\"
push \"dhcp-option DNS 8.8.8.8\"
push \"dhcp-option DNS 8.8.4.4\"
keepalive 10 120
cipher AES-128-CBC   # AES
comp-lzo
;max-clients 100
user nobody
group nobody
persist-key
persist-tun
status openvpn-status-udp.log
log         /etc/openvpn/openvpn-udp.log
;log-append  openvpn.log
verb 3
"

opvpn6="local $ipv6
port 9999
proto udp6
dev tun
ca /etc/openvpn/2.0/keys/ca.crt
cert /etc/openvpn/2.0/keys/server.crt
key /etc/openvpn/2.0/keys/server.key  # This file should be kept secret
dh /etc/openvpn/2.0/keys/dh1024.pem
server 10.3.1.0 255.255.255.0
ifconfig-pool-persist /etc/ipp-udp6.txt
push \"redirect-gateway def1 bypass-dhcp\"
push \"dhcp-option DNS 10.3.1.1\"
push \"dhcp-option DNS 8.8.8.8\"
push \"dhcp-option DNS 8.8.4.4\"
keepalive 10 120
cipher AES-128-CBC   # AES
comp-lzo
;max-clients 100
user nobody
group nobody
persist-key
persist-tun
status /var/log/openvpn-status-udp6.log
log         /etc/openvpn/openvpn-udp6.log
;log-append  openvpn.log
verb 3
"

echo "$opvpn4" > /etc/openvpn/2.0/conf/openvpn.conf
echo "$opvpn6" > /etc/openvpn/2.0/conf/openvpn6.conf


sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.3.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.3.1.0/24 -o eth0 -j MASQUERADE

openvpn --config /etc/openvpn/2.0/conf/server-udp.conf --daemon &
openvpn --config /etc/openvpn/2.0/conf/server-udp6.conf --deamon &

echo "OpenVPN has been installed
Download /root/keys.tgz using winscp or other sftp/scp client such as filezilla" 



