from runpy import run_path
from socket import SO_RCVTIMEO
import sys
import argparse
import datetime
from time import time
from netaddr import IPNetwork, IPAddress, IPSet
import pyshark
import numpy as np
from datetime import datetime
import traceback
import paramiko
import requests
import json
import joblib

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
offenders = {}
offenders_window_tstamp = 0
clf = None

Classes = {0:'DoH Browsing',1:'HTTPS Browsing',2:'DNS Tunneling'}

def report_offender(offenderIP, DoH_class):
    invalid_conf_alert = json.dumps([{ 
        "status": "firing",
        "labels": {
                "alertname": "DoH Use Detected - " + DoH_class,
                "severity":"warning", "exported_instance": str(offenderIP)
        },
        "annotations": {
                "description": "DNS-Over-HTTPS traffic of the " + DoH_class + " type was detected.\nThe host is assumed compromised and all of its L3 traffic is now being blocked.", "owners": "<@U030QQ6D1B7> <@U030D3D25RD>"
        }
    }])
    res = requests.post("https://tpr.rrosmaninho.com/api/v1/alerts", data=invalid_conf_alert)

def get_ssh_connection(ssh_machine, ssh_username, ssh_password):
    """Establishes a ssh connection to execute command.
    :param ssh_machine: IP of the machine to which SSH connection to be established.
    :param ssh_username: User Name of the machine to which SSH connection to be established..
    :param ssh_password: Password of the machine to which SSH connection to be established..
    returns connection Object
    """
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(hostname=ssh_machine, username=ssh_username, password=ssh_password, timeout=10)
    return client
      
def run_sudo_command(ssh_username="user", ssh_password="1", ssh_machine="10.10.3.1", command="ls",
                        jobid="None"):
    """Executes a command over a established SSH connectio.
    :param ssh_machine: IP of the machine to which SSH connection to be established.
    :param ssh_username: User Name of the machine to which SSH connection to be established..
    :param ssh_password: Password of the machine to which SSH connection to be established..
    returns status of the command executed and Output of the command.
    """
    conn = get_ssh_connection(ssh_machine=ssh_machine, ssh_username=ssh_username, ssh_password=ssh_password)
    command = "sudo -S -p '' %s" % command
    stdin, stdout, stderr = conn.exec_command(command=command)
    stdin.write(ssh_password + "\n")
    stdin.flush()
    stdoutput = [line for line in stdout]
    stderroutput = [line for line in stderr]
    if not stdout.channel.recv_exit_status():
        conn.close()
        if not stdoutput:
            stdoutput = True
        return True, stdoutput
    else:
        conn.close()
        return False, stderroutput

def block_offender(offenderIP):
    # ssh = paramiko.SSHClient()
    # ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    # ssh.connect('10.10.3.1', username='user', password='1',port=22,allow_agent=False,look_for_keys=False)
    
    # channel = ssh.invoke_shell()
    # out=channel.recv(9999)
    
    # channel.send('sudo iptables -I INPUT -s ' + str(offenderIP) + ' -j DROP\n')
    # while not channel.recv_ready():
    #     time.sleep(1)
    # out=channel.recv(9999)
    # print(out.decode('ascii'))
    
    # channel.send('user\n')
    # while not channel.recv_ready():
    #     time.sleep(1)
    # out=channel.recv(9999)
    # print(out.decode('ascii'))
    # ssh.close()
    res = run_sudo_command(command=f"iptables -I FORWARD 1 -s ' + {str(offenderIP)} + ' -j DROP")
    print(res)


def classify(flow, srcIP, dstIP):
    global offenders, offenders_window_tstamp

    now = datetime.now().timestamp()
    if now - offenders_window_tstamp > 30:
        offenders = {}
        offenders_window_tstamp = now

    soma = np.sum(flow[3])
    burstThreshold = np.percentile(flow[6], 100 * (1/3))
    pauseThreshold = np.percentile(flow[6], 100 * (2/3))
    pktInBursts = len([p for p in flow[6] if p < burstThreshold])
    pktInPauses = len([p for p in flow[6] if p > pauseThreshold])

    flow_features = {
        "minIntrPckDelay": np.min(flow[6]),
        "maxIntrPckDelay": np.max(flow[6]),
        "avgIntrPckDelay": np.average(flow[6]),
        "varPktSizeIn": np.var(flow[5]) if len(flow[5]) > 0 else 0,
        "varPktSizeOut": np.var(flow[3]) if len(flow[3]) > 0 else 0,
        "bytesInoutRatio": (np.sum(flow[5]) / soma) if soma != 0 else sys.maxsize,
        "pktsInoutRatio": (flow[4] / flow[2]) if flow[2] != 0 else sys.maxsize,
        "avgPktSizeIn": np.average(flow[5]) if len(flow[5]) > 0 else 0,
        "avgPktSizeOut": np.average(flow[3]) if len(flow[3]) > 0 else 0,
        "medianPktSizeIn": np.mean(flow[5]) if len(flow[5]) > 0 else 0,
        "medianPktSizeOut": np.mean(flow[3]) if len(flow[3]) > 0 else 0,
        "pktInBursts": pktInBursts,
        "pktInPauses": pktInPauses,
        "burstPausesRatio": (pktInPauses / pktInBursts) if pktInBursts != 0 else sys.maxsize
    }
    
    data = np.array(list(flow_features.values()))
    data = data.reshape(1, -1)
    print(data)
    result = clf.predict(data)
    print(result)
    print("(" + str(srcIP) + ", " + str(dstIP) + ") -> Class: " + str(Classes[result[0]]))

    if result[0] != 1: # TODO: Condition if flow is DoH
        offenders[srcIP] = (offenders[srcIP] + 1) if srcIP in offenders else 1
        if offenders[srcIP] > 5:
            if offenders[srcIP] == 5: block_offender(srcIP)
            report_offender(srcIP, Classes[result[0]])
            print("DoH of type " + Classes[result[0]] + " detected on Host " + str(srcIP))


def pktHandler(pkt, sampDelta=1):
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
        if not pkt.tcp.flags_syn.int_value:
            return
        flows[key] = [timestamp, 0, 0, [], 0, [], [], timestamp, 0]
    flow = flows[key]

    offender = IPAddress(key[0][0]) if IPAddress(key[0][0]) in scnets else IPAddress(key[1][0])
    server = IPAddress(key[1][0]) if IPAddress(key[1][0]) not in scnets else IPAddress(key[0][0])

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
        classify(flow, offender , server)
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
            classify(flow, offender, server)
        del flows[key]


def main():
    global f_doh, f_https, clf

    parser=argparse.ArgumentParser()
    parser.add_argument('-c', '--cnet', nargs='+',required=True, help='client network(s)')
    parser.add_argument('-s', '--snet', nargs='+',required=True, help='internet network(s)')

    args=parser.parse_args()

    clf = joblib.load("ExtraTreesClassifier.model")
    
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
        
    capture = pyshark.LiveCapture(interface="enp0s3", display_filter="ip && tcp.port==443")
    for pkt in capture.sniff_continuously():
        pktHandler(pkt)

if __name__ == '__main__':
    main()
