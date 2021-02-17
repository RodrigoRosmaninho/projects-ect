sudo ip address add 192.168.0.81/24 dev enp2s0
sudo ip address add 192.168.0.83/24 dev enp2s0
sudo ip link add name gns_tun0 type gretap local 192.168.0.81 remote 192.168.0.80
sudo ip link add name gns_tun1 type gretap local 192.168.0.83 remote 192.168.0.82
sudo ip link set gns_tun0 up
sudo ip link set gns_tun1 up
