#coding: utf-8
require 'open-uri'

routes = []

up_title = <<INNER
@echo off
@echo off
 for /F "tokens=3" %%* in ('route print ^| findstr "\<0.0.0.0\>"') do (  echo maybe is %%* )
 echo input your gateway ......
 set /p gw=%maybe%
 echo please set your selection
 echo 1.ipgw
 echo 2.cernet
 set "select=1"
 set /p select=%select%

if  %select%==1 goto IPGW

if  %select%==2 goto SERNET

:sernet
route add 1.51.0.0 mask 255.255.0.0 %gw% metric 5
route add 1.184.0.0 mask 255.254.0.0 %gw% metric 5
route add 42.244.0.0 mask 255.252.0.0 %gw% metric 5
route add 49.52.0.0 mask 255.252.0.0 %gw% metric 5
route add 49.120.0.0 mask 255.252.0.0 %gw% metric 5
route add 49.140.0.0 mask 255.254.0.0 %gw% metric 5
route add 49.208.0.0 mask 255.254.0.0 %gw% metric 5
route add 58.17.0.0 mask 255.255.0.0 %gw% metric 5
route add 58.24.0.0 mask 255.254.0.0 %gw% metric 5
route add 58.154.0.0 mask 255.254.0.0 %gw% metric 5
route add 58.192.0.0 mask 255.240.0.0 %gw% metric 5
route add 58.240.0.0 mask 255.254.0.0 %gw% metric 5
route add 59.32.0.0 mask 255.240.0.0 %gw% metric 5
route add 59.64.0.0 mask 255.240.0.0 %gw% metric 5
route add 60.0.0.0 mask 255.224.0.0 %gw% metric 5
route add 60.63.0.0 mask 255.255.0.0 %gw% metric 5
route add 61.28.0.0 mask 255.255.240.0 %gw% metric 5
route add 61.48.0.0 mask 255.248.0.0 %gw% metric 5
route add 61.128.0.0 mask 255.192.0.0 %gw% metric 5
route add 61.232.0.0 mask 255.252.0.0 %gw% metric 5
route add 61.236.0.0 mask 255.254.0.0 %gw% metric 5
route add 61.240.0.0 mask 255.252.0.0 %gw% metric 5
route add 101.4.0.0 mask 255.252.0.0 %gw% metric 5
route add 101.76.0.0 mask 255.254.0.0 %gw% metric 5
route add 110.64.0.0 mask 255.254.0.0 %gw% metric 5
route add 111.114.0.0 mask 255.254.0.0 %gw% metric 5
route add 111.116.0.0 mask 255.254.0.0 %gw% metric 5
route add 111.186.0.0 mask 255.254.0.0 %gw% metric 5
route add 113.54.0.0 mask 255.254.0.0 %gw% metric 5
route add 114.212.0.0 mask 255.254.0.0 %gw% metric 5
route add 114.214.0.0 mask 255.255.0.0 %gw% metric 5
route add 115.24.0.0 mask 255.252.0.0 %gw% metric 5
route add 115.154.0.0 mask 255.254.0.0 %gw% metric 5
route add 115.156.0.0 mask 255.254.0.0 %gw% metric 5
route add 115.158.0.0 mask 255.255.0.0 %gw% metric 5
route add 116.13.0.0 mask 255.255.0.0 %gw% metric 5
route add 116.56.0.0 mask 255.254.0.0 %gw% metric 5
route add 118.202.0.0 mask 255.254.0.0 %gw% metric 5
route add 118.228.0.0 mask 255.254.0.0 %gw% metric 5
route add 118.230.0.0 mask 255.255.0.0 %gw% metric 5
route add 120.94.0.0 mask 255.254.0.0 %gw% metric 5
route add 121.48.0.0 mask 255.254.0.0 %gw% metric 5
route add 121.52.160.0 mask 255.255.224.0 %gw% metric 5
route add 121.192.0.0 mask 255.252.0.0 %gw% metric 5
route add 121.248.0.0 mask 255.252.0.0 %gw% metric 5
route add 122.204.0.0 mask 255.252.0.0 %gw% metric 5
route add 125.216.0.0 mask 255.248.0.0 %gw% metric 5
route add 137.189.0.0 mask 255.255.0.0 %gw% metric 5
route add 140.113.0.0 mask 255.255.0.0 %gw% metric 5
route add 143.89.0.0 mask 255.255.0.0 %gw% metric 5
route add 144.214.0.0 mask 255.255.0.0 %gw% metric 5
route add 147.8.0.0 mask 255.255.0.0 %gw% metric 5
route add 152.101.0.0 mask 255.255.0.0 %gw% metric 5
route add 152.104.0.0 mask 255.255.0.0 %gw% metric 5
route add 158.132.0.0 mask 255.255.0.0 %gw% metric 5
route add 158.182.0.0 mask 255.255.0.0 %gw% metric 5
route add 159.226.0.0 mask 255.255.0.0 %gw% metric 5
route add 161.207.0.0 mask 255.255.0.0 %gw% metric 5
route add 162.105.0.0 mask 255.255.0.0 %gw% metric 5
route add 166.111.0.0 mask 255.255.0.0 %gw% metric 5
route add 167.139.0.0 mask 255.255.0.0 %gw% metric 5
route add 168.160.0.0 mask 255.255.0.0 %gw% metric 5
route add 175.185.0.0 mask 255.255.0.0 %gw% metric 5
route add 175.186.0.0 mask 255.254.0.0 %gw% metric 5
route add 180.84.0.0 mask 255.254.0.0 %gw% metric 5
route add 180.201.0.0 mask 255.255.0.0 %gw% metric 5
route add 180.208.0.0 mask 255.254.0.0 %gw% metric 5
route add 183.168.0.0 mask 255.254.0.0 %gw% metric 5
route add 183.170.0.0 mask 255.255.0.0 %gw% metric 5
route add 183.172.0.0 mask 255.252.0.0 %gw% metric 5
route add 192.86.104.0 mask 255.255.255.0 %gw% metric 5
route add 202.4.128.0 mask 255.255.224.0 %gw% metric 5
route add 202.38.0.0 mask 255.255.0.0 %gw% metric 5
route add 202.40.192.0 mask 255.255.224.0 %gw% metric 5
route add 202.45.32.0 mask 255.255.224.0 %gw% metric 5
route add 202.75.64.0 mask 255.255.224.0 %gw% metric 5
route add 202.84.16.0 mask 255.255.254.0 %gw% metric 5
route add 202.95.0.0 mask 255.255.224.0 %gw% metric 5
route add 202.96.0.0 mask 255.240.0.0 %gw% metric 5
route add 202.112.0.0 mask 255.248.0.0 %gw% metric 5
route add 202.120.0.0 mask 255.254.0.0 %gw% metric 5
route add 202.122.32.0 mask 255.255.240.0 %gw% metric 5
route add 202.127.0.0 mask 255.255.192.0 %gw% metric 5
route add 202.127.128.0 mask 255.255.128.0 %gw% metric 5
route add 202.130.0.0 mask 255.255.224.0 %gw% metric 5
route add 202.130.224.0 mask 255.255.224.0 %gw% metric 5
route add 202.131.208.0 mask 255.255.240.0 %gw% metric 5
route add 202.189.96.0 mask 255.255.224.0 %gw% metric 5
route add 202.192.0.0 mask 255.240.0.0 %gw% metric 5
route add 203.81.16.0 mask 255.255.240.0 %gw% metric 5
route add 203.87.224.0 mask 255.255.224.0 %gw% metric 5
route add 203.93.0.0 mask 255.255.0.0 %gw% metric 5
route add 203.128.128.0 mask 255.255.224.0 %gw% metric 5
route add 203.192.0.0 mask 255.255.224.0 %gw% metric 5
route add 203.207.64.0 mask 255.255.192.0 %gw% metric 5
route add 203.207.128.0 mask 255.255.128.0 %gw% metric 5
route add 203.208.0.0 mask 255.255.224.0 %gw% metric 5
route add 203.212.0.0 mask 255.255.240.0 %gw% metric 5
route add 210.5.0.0 mask 255.255.224.0 %gw% metric 5
route add 210.12.0.0 mask 255.254.0.0 %gw% metric 5
route add 210.14.160.0 mask 255.255.224.0 %gw% metric 5
route add 210.14.192.0 mask 255.255.192.0 %gw% metric 5
route add 210.15.0.0 mask 255.255.128.0 %gw% metric 5
route add 210.15.128.0 mask 255.255.192.0 %gw% metric 5
route add 210.21.0.0 mask 255.255.0.0 %gw% metric 5
route add 210.22.0.0 mask 255.255.0.0 %gw% metric 5
route add 210.25.0.0 mask 255.255.128.0 %gw% metric 5
route add 210.25.128.0 mask 255.255.192.0 %gw% metric 5
route add 210.26.0.0 mask 255.254.0.0 %gw% metric 5
route add 210.28.0.0 mask 255.252.0.0 %gw% metric 5
route add 210.32.0.0 mask 255.240.0.0 %gw% metric 5
route add 210.51.0.0 mask 255.255.0.0 %gw% metric 5
route add 210.52.0.0 mask 255.254.0.0 %gw% metric 5
route add 210.72.0.0 mask 255.252.0.0 %gw% metric 5
route add 210.76.0.0 mask 255.254.0.0 %gw% metric 5
route add 210.78.0.0 mask 255.255.0.0 %gw% metric 5
route add 210.79.224.0 mask 255.255.224.0 %gw% metric 5
route add 210.82.0.0 mask 255.254.0.0 %gw% metric 5
route add 210.192.96.0 mask 255.255.224.0 %gw% metric 5
route add 211.64.0.0 mask 255.248.0.0 %gw% metric 5
route add 211.80.0.0 mask 255.240.0.0 %gw% metric 5
route add 211.96.0.0 mask 255.248.0.0 %gw% metric 5
route add 211.136.0.0 mask 255.248.0.0 %gw% metric 5
route add 211.144.0.0 mask 255.240.0.0 %gw% metric 5
route add 211.160.0.0 mask 255.248.0.0 %gw% metric 5
route add 218.0.0.0 mask 255.224.0.0 %gw% metric 5
route add 218.56.0.0 mask 255.248.0.0 %gw% metric 5
route add 218.64.0.0 mask 255.224.0.0 %gw% metric 5
route add 218.96.0.0 mask 255.252.0.0 %gw% metric 5
route add 218.104.0.0 mask 255.252.0.0 %gw% metric 5
route add 218.108.0.0 mask 255.255.0.0 %gw% metric 5
route add 218.192.0.0 mask 255.240.0.0 %gw% metric 5
route add 218.240.0.0 mask 255.248.0.0 %gw% metric 5
route add 219.72.0.0 mask 255.255.0.0 %gw% metric 5
route add 219.128.0.0 mask 255.224.0.0 %gw% metric 5
route add 219.216.0.0 mask 255.248.0.0 %gw% metric 5
route add 219.224.0.0 mask 255.240.0.0 %gw% metric 5
route add 219.242.0.0 mask 255.254.0.0 %gw% metric 5
route add 219.244.0.0 mask 255.252.0.0 %gw% metric 5
route add 220.160.0.0 mask 255.224.0.0 %gw% metric 5
route add 220.192.0.0 mask 255.240.0.0 %gw% metric 5
route add 220.234.0.0 mask 255.255.0.0 %gw% metric 5
route add 220.248.0.0 mask 255.252.0.0 %gw% metric 5
route add 220.252.0.0 mask 255.255.0.0 %gw% metric 5
route add 221.0.0.0 mask 255.240.0.0 %gw% metric 5
route add 221.130.0.0 mask 255.254.0.0 %gw% metric 5
route add 221.137.0.0 mask 255.255.0.0 %gw% metric 5
route add 221.172.0.0 mask 255.252.0.0 %gw% metric 5
route add 221.192.0.0 mask 255.248.0.0 %gw% metric 5
route add 221.200.0.0 mask 255.252.0.0 %gw% metric 5
route add 221.204.0.0 mask 255.254.0.0 %gw% metric 5
route add 221.208.0.0 mask 255.252.0.0 %gw% metric 5
route add 221.212.0.0 mask 255.255.0.0 %gw% metric 5
route add 221.214.0.0 mask 255.254.0.0 %gw% metric 5
route add 221.216.0.0 mask 255.248.0.0 %gw% metric 5
route add 221.224.0.0 mask 255.240.0.0 %gw% metric 5
route add 222.16.0.0 mask 255.240.0.0 %gw% metric 5
route add 222.32.0.0 mask 255.224.0.0 %gw% metric 5
route add 222.64.0.0 mask 255.224.0.0 %gw% metric 5
route add 222.132.0.0 mask 255.252.0.0 %gw% metric 5
route add 222.136.0.0 mask 255.248.0.0 %gw% metric 5
route add 222.160.0.0 mask 255.252.0.0 %gw% metric 5
route add 222.168.0.0 mask 255.248.0.0 %gw% metric 5
route add 222.176.0.0 mask 255.240.0.0 %gw% metric 5
route add 222.192.0.0 mask 255.240.0.0 %gw% metric 5
route add 222.208.0.0 mask 255.248.0.0 %gw% metric 5
route add 222.216.0.0 mask 255.254.0.0 %gw% metric 5
route add 222.218.0.0 mask 255.255.0.0 %gw% metric 5
route add 222.222.0.0 mask 255.254.0.0 %gw% metric 5
route add 222.240.0.0 mask 255.248.0.0 %gw% metric 5
route add 223.2.0.0 mask 255.254.0.0 %gw% metric 5
route add 223.128.0.0 mask 255.254.0.0 %gw% metric 5
goto end

:ipgw

INNER
end_string = <<END
goto end

:end
echo 你的网关已经处理完毕！
END
routes <<  up_title
open('http://www.nic.edu.cn/RS/ipstat/internalip/real.html') do |f|
  routes << f.each_line do |line|
     if  line.match(/([\d\.]+)\s+[\d\.+]+\s+([\d\.]+)/)
       ips = "route add #$1 mask #$2 %gw% metric 5"
       routes << ips
     end
  end
end
routes.pop
routes_up = routes.join("\n").to_s + end_string
routes_down = routes.join("\n").gsub("add", "delete").to_s + end_string

File.open("routes_up.bat","w+") do |f|
  f.write   routes_up
end

File.open("routes_down.bat","w+") do |f|
  f.write   routes_down
end
puts    routes_up
