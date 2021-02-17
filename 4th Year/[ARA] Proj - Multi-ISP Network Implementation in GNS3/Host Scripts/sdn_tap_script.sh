sudo ip tuntap add name tap0 mode tap
sudo ip link set up dev tap0
sudo ip addr add 10.0.0.100/24 dev tap0
