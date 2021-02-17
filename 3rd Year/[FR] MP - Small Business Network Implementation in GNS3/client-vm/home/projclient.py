import socket
import signal
import sys
import datetime
import struct
import psutil
import time
from datetime import datetime

def signal_handler(sig, frame):
    print('\nDone!')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
print('Press Ctrl+C to exit...')

##

ip_addr = "projeto.pt"
tcp_port = 5005

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

sock.connect((ip_addr, tcp_port))

order=0
while True:
    try:
        time.sleep(1)
        now = datetime.now()
        date_time = now.strftime("%d/%m/%Y, %H:%M:%S")
        message=("TIME: " + date_time + " CPU: "+str(psutil.cpu_percent())+" RAM: "+str(psutil.virtual_memory()[2])+"\n").encode()
        #message=("HelloWorld!\n").encode()
        version=1
        order+=1
        size=len(message)
        pkt=struct.pack('!BLL{}s'.format(size),version,size,order,message)
        sock.send(pkt)
    except (socket.timeout, socket.error):
        print('Server error. Done!')
        sys.exit(0)

