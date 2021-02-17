sudo ip address add 192.168.0.80/24 dev eno2
sudo ip address add 192.168.0.82/24 dev eno2
sudo ip link add name gns_tun0 type gretap local 192.168.0.80 remote 192.168.0.81
sudo ip link add name gns_tun1 type gretap local 192.168.0.82 remote 192.168.0.83
sudo ip link set gns_tun0 up
sudo ip link set gns_tun1 up
