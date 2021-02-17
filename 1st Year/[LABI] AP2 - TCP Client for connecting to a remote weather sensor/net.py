#coding=utf-8

# Código fonte do projeto AP2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-ap2-g3

# Grupo #3
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5

# TODO: Adicionar a estes comentários preliminares uma descrição do objetivo deste ficheiro

import socket, sys, base64
import colors

tcp_s = ""
server_addr = ("", 0)

# Função tcpSend : Enviar 'data' para o servidor
def tcpSend(data, isEncrypted):
    if isEncrypted:
        data = base64.b64encode(data) + b'\n'
    else:
        data = (data + "\n").encode()
    # É necessário, de acordo com o guião, que cada mensagem enviada para o servidor termine com newline
    tcp_s.sendto(data, server_addr)

# Função tcpRead : Devolver dados recebidos do servidor
def tcpRead():
    return tcp_s.recv(4096)

# Função tcpConnect : Abrir socket TCP e conectar-se ao xcoa. Dar valor às variáveis globais e devolver o socket
def tcpConnect(addr):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect( addr )
        
    except KeyboardInterrupt:
        sock.close()
        sys.exit(0)
    except:
        print(colors.FAIL + "Erro ao conectar. Verifique se está ligado à internet e que o servidor está ligado." + colors.ENDC)
        sys.exit(2)
    
    global tcp_s, server_addr # Obter variáveis globais para alterar o seu valor
    tcp_s = sock
    server_addr = addr
    return sock