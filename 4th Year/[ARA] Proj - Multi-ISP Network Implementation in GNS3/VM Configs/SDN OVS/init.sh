#!/bin/bash
ip link set up br0
ip link set up eth7
ip addr add 10.0.0.200/24 dev br0
ovs-vsctl set bridge br0 protocols=OpenFlow13
ip link set up eth0
ip link set up eth1
ip link set up eth2
ip link set up eth3

