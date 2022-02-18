import sys
import argparse
import datetime
from netaddr import IPNetwork, IPAddress, IPSet
import pyshark
import numpy as np
from datetime import datetime
from operator import itemgetter

class BiFlowKey(tuple):
    __slots__ = []
    def __hash__(self) -> int:
        return self.src.__hash__() + self.dst.__hash__()
    def __new__(cls, src, dst):
        return tuple.__new__(cls, (src, dst))
    def __eq__(self, __o: object) -> bool:
        return (self.src == __o.src and self.dst == __o.dst) or (self.src == __o.dst and self.dst == __o.src)
    src = property(itemgetter(0))
    dst = property(itemgetter(1))
        
flows = {}
features = []

flush_tstamp = {}

def print_features(flow, srcIP, dstIP):
    soma = np.sum(flow[3])
    burst_threshold = np.percentile(flow[6], 100 * (1/3))
    pause_threshold = np.percentile(flow[6], 100 * (2/3))
    packet_bursts = len([p for p in flow[6] if p < burst_threshold])
    packet_pauses = len([p for p in flow[6] if p > pause_threshold])

    flow_features = {
        "is_doh": (IPAddress(srcIP) in scnets and IPAddress(dstIP) in ssnets) or (IPAddress(srcIP) in ssnets and IPAddress(dstIP) in scnets),
        "min_ipdelay": np.min(flow[6]),
        "max_ipdelay": np.max(flow[6]),
        "avg_ipdelay": np.average(flow[6]),
        "var_packet_bytes_in": np.var(flow[5]) if len(flow[5]) > 0 else 0,
        "var_packet_bytes_out": np.var(flow[3]) if len(flow[3]) > 0 else 0,
        "bytes_io_ratio": (np.sum(flow[5]) / soma) if soma != 0 else sys.maxsize,
        "packets_io_ratio": (flow[4] / flow[2]) if flow[2] != 0 else sys.maxsize,
        "avg_packet_bytes_in": np.average(flow[5]) if len(flow[5]) > 0 else 0,
        "avg_packet_bytes_out": np.average(flow[3]) if len(flow[3]) > 0 else 0,
        "median_packet_bytes_in": np.median(flow[5]) if len(flow[5]) > 0 else 0,
        "median_packet_bytes_out": np.median(flow[3]) if len(flow[3]) > 0 else 0,
        "packet_bursts": packet_bursts,
        "packet_pauses": packet_pauses,
        "burst_pause_ratio": (packet_pauses / packet_bursts) if packet_bursts != 0 else sys.maxsize
    }
    
    f = f_doh if flow_features["is_doh"] else f_https
    print(" ".join([str(flow_features[k]) for k in flow_features if k != "is_doh"]), file=f)
    
    now = datetime.now().timestamp()
    if now - flush_tstamp[f] > 60:
        f.flush()
        flush_tstamp[f] = now

def pktHandler(pkt, sampDelta=1):
    global scnets
    global ssnets
    global npkts
    has_printed = False

    timestamp,srcIP,dstIP,lengthIP=float(pkt.sniff_timestamp),pkt.ip.src,pkt.ip.dst,pkt.ip.len

    try:
        key = BiFlowKey((srcIP, pkt.tcp.srcport), (dstIP, pkt.tcp.dstport))
    except AttributeError:
        print("AttributeError")
        print(pkt)
        print("\nProceeding...")
        return

    if key not in flows:
        # if not pkt.tcp.flags_syn.int_value:
        #     return
        flows[key] = [timestamp, 0, 0, [], 0, [], [], timestamp, 0]
    flow = flows[key]

    ks = int((float(timestamp)-flow[0])/sampDelta)

    if IPAddress(srcIP) in scnets: #Upload
        flow[2]+=1
        flow[3].append(int(lengthIP))

    if IPAddress(dstIP) in scnets: #Download
        flow[4]+=1
        flow[5].append(int(lengthIP))

    flow[6].append(timestamp - flow[7])

    if ks>flow[1]:
        has_printed = True
        print_features(flow, srcIP, dstIP)
        flow[2] = 0
        flow[3] = []
        flow[4] = 0
        flow[5] = []
        flow[6] = []

    flow[1] = int((float(timestamp)-flow[0])/sampDelta)
    flow[7] = timestamp

    if pkt.tcp.flags_fin.int_value and pkt.tcp.flags_ack.int_value:
        flow[8]+=1

    if flow[8] == 2 or pkt.tcp.flags_reset.int_value:
        if not has_printed:
            print_features(flow, srcIP, dstIP)
        del flows[key]


def main():
    global f_doh, f_https

    parser=argparse.ArgumentParser()
    parser.add_argument('-i', '--input', nargs='?',required=True, help='input file')
    parser.add_argument('-f', '--format', nargs='?',required=True, help='format',default=1)
    parser.add_argument('-c', '--cnet', nargs='+',required=True, help='client network(s)')
    parser.add_argument('-s', '--snet', nargs='+',required=True, help='service network(s)')

    f_doh = open("doh.dat", "a")
    f_https = open("https_browsing.dat", "a")

    now = datetime.now().timestamp()
    flush_tstamp[f_doh] =  now
    flush_tstamp[f_https] = now

    args=parser.parse_args()
    
    cnets=[]
    for n in args.cnet:
        try:
            nn=IPNetwork(n)
            cnets.append(nn)
        except:
            print('{} is not a network prefix'.format(n))
    #print(cnets)
    if len(cnets)==0:
        print("No valid client network prefixes.")
        sys.exit()
    global scnets
    scnets=IPSet(cnets)

    snets=[""]
    for n in args.snet:
        try:
            nn=IPNetwork(n)
            snets.append(nn)
        except:
            print('{} is not a network prefix'.format(n))
    #print(snets)
    if len(snets)==0:
        print("No valid service network prefixes.")
        sys.exit()
        
    global ssnets
    ssnets=[IPAddress("104.16.249.249"), IPAddress("104.16.248.249"), IPAddress("149.112.112.12"), IPAddress("9.9.9.12")] #IPSet(snets)
        
    fileInput=args.input
    fileFormat=int(args.format)
        
    global npkts
    global T0
    global outc
    global last_ks

    npkts=0
    outc=[0,0,0,0]
    sampDelta=1
    #print('Sampling interval: {} second'.format(sampDelta))

    if fileFormat in [1,2]:
        file = open(fileInput,'r') 
        for line in file: 
            pktData=line.split()
            if fileFormat==1 and len(pktData)==9: #script format
                timestamp,srcIP,dstIP,lengthIP=pktData[0],pktData[4],pktData[6],pktData[8]
                pktHandler(timestamp,srcIP,dstIP,lengthIP,sampDelta)
            elif fileFormat==2 and len(pktData)==4: #tshark format "-T fileds -e frame.time_relative -e ip.src -e ip.dst -e ip.len"
                timestamp,srcIP,dstIP,lengthIP=pktData[0],pktData[1],pktData[2],pktData[3]
                pktHandler(timestamp,srcIP,dstIP,lengthIP,sampDelta)
        file.close()
    elif fileFormat==3: #pcap format
        capture = pyshark.FileCapture(fileInput, display_filter="tcp.port==443 && ip.dst_host != 192.168.122.193")
        for pkt in capture:
            pktHandler(pkt)

    f_doh.close()
    f_https.close()


if __name__ == '__main__':
    main()
