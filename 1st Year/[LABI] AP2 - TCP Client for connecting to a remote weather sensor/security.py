#!/bin/env/python3
#coding=utf-8

# Código fonte do projeto AP2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática ##
# Projeto: http://code.ua.pt/projects/labi2018-ap2-g3

# Grupo #3
#NMEC:	88802	NOME:	Rodrigo Rosmaninho	TURMA:	P5
#NMEC:	72783	NOME:	Eurico Dias			TURMA:	P5

from Crypto.Hash import MD5, SHA256
from Crypto.Cipher import AES

import base64, math, random, sys
import colors

a = 0

#########################################################################################################################

#Calcula os valores para a troca de chaves pelo metodo de Diffie-Hellmann
def DHInitialValues():
	
	global a
	params = _genParameters(127,100) # tamanho de p e q respetivamente, len(p) >= len(q)

	p, q = params

	g = _getGenerator(p, q)

	a = random.SystemRandom().randint(pow(2,99), q-2) # inteiro entre [2^(len(q)-1),q-2], como descrito no standard

	val = pow(g, a, p)

	return val, p, g

#########################################################################################################################

def DHGetSecret(p,B):
	global a
	return hashKey(pow(B,a,p))

#########################################################################################################################

# Faz o hashing da chave partilhada
def hashKey(key):
	key = str(key).encode()
	md5 = MD5.new()
	md5.update(key)

	return md5.hexdigest()

#########################################################################################################################

# Cifra uma mensagem recorrendo ao algoritmo AES.
def encrypt(key, msg):
	if len(key) != 32: # 32 hex => 16 bytes (2 bytes por cada carater hex)
		print(colors.fail("Error in key generation. Exiting"))
		sys.exit(1)

	key = key[:16].encode()
	aes = AES.new(key, AES.MODE_ECB) # MODE_ECB não tem atributo block_size nalgumas versões do Crypto

	try:
		size = aes.block_size
	except AttributeError:
		size = len(key)

	encmsg = b''
	
	j = 0
	for i in range(0, int(math.ceil(len(msg) / size))):

		block = msg[size*i:size*(i+1)].encode()
		
		if len(block) % size != 0:
			block += b' '*(size - len(block) % size)

		encmsg += aes.encrypt(block)

	return encmsg

#########################################################################################################################

# Descodifica uma mensagem encriptada (AES), codificada em Base64 e desencripta-a.
def decrypt(key, msg):
	msg = base64.b64decode(msg)

	if len(key) != 32: # 32 hex => 16 bytes (2 bytes por cada carater hex)
		hashKey(key)

	key = key[:16].encode()
	aes = AES.new(key, AES.MODE_ECB) # MODE_ECB não tem atributo block_size nalgumas versões do Crypto
	
	try:
		size = aes.block_size
	except AttributeError:
		size = len(key)

	decmsg = aes.decrypt(msg)
	return _unpadJSON(decmsg.decode())

########################################################################################################################

# Retira o excipiente da mensagem desencriptada, sabendo que a mensagem e um objeto JSON.
def _unpadJSON(msg):
	if len(msg) < 2:
		return ""

	i = -1
	
	while msg[i] is not '}' and i != -1*(len(msg)):
		i -= 1

	return msg[:len(msg) - (abs(i)-1)] if i != -1*(len(msg)) else ""

#########################################################################################################################

# Gera um primo p e um gerador g correspondentes para o método
# Adaptado de ANSI X9-42 (1998)/RFC 2631(1999)
def _genParameters(l,m):

	if m > 128:
	 	print(colors.fail("Seed length must be at most 128 bits. Exiting."))
	 	sys.exit(1)
	if l > 128:
	 	print(colors.fail("Prime length must be at most 128 bits. Exiting."))
	 	sys.exit(1)

	dl = int(math.ceil(l/32)) # para conformizar com valores mais pequenos de p
	dm = int(math.ceil(m/32)) # idem
	n = int(math.ceil(l/512)) # n não precisa de ser tão grande como descrito no standard

	while True:
		seed = random.SystemRandom().getrandbits(m)
		q = _genQ(seed, m, dm)
		if _checkPrime(q, 50):
			break
	
	counter = 0
	while counter < 4096*n:
		r = seed + 2*dm + (dl * counter)
		p = _genP(q, r, l, dl)

		if p > pow(2,l-1):
			if (_checkPrime(p, 50)):
				return p, q

		counter += 1

	print(colors.fail("Failed to generate parameters. Exiting."))
	sys.exit(1)

#gera o parametro q
def _genQ(seed, m, dm):
	q = 0

	while True:
		for i in range(0, dm-1):
			hash1 = SHA256.new()
			hash2 = SHA256.new()
			val1 = seed + i
			val2 = seed + dm + i
			hash1.update(str(val1).encode())
			hash2.update(str(val2).encode())
			q += (int(hash1.hexdigest(), 16) ^ int(hash2.hexdigest(), 16)) * pow(2,256*i)
	
		q = (q | pow(2,m-1) | 1) % pow(2,m)

		return q

#gera o parametro p
def _genP(q, r, l, dl):
	p = 0

	for i in range(0,dl-1):
		val = r+i
		hash1 =  SHA256.new()
		hash1.update(str(val).encode())
		p += int(hash1.hexdigest(), 16)*pow(2,256*i)

	p = (p | pow(2,l-1)) % pow(2,l)
	p -= (p % (2*q)) + 1

	return p

##############################################################################################

# Encontra um gerador g ordem q de GF(p) (GF = Galois Field [ou campo de Galois]).
# 	Simplificando as definicoes e demostracoes, sera encontrado um numero g tal que g^j % p != 1,
# 	com j=(p-1)/q (deduzido da equacao anterior).
# Adaptado de ANSI X9-42 (1998)/RFC 2631(1999))
def _getGenerator(p, q):
	j = int((p - 1) / q)
	while True:
		if p <= q:
			print(colors.fail("Generator can't be calculated. Exiting."))
			sys.exit(1)
		g = random.SystemRandom().randint(2,p-2)
		if pow(g, j, p) != 1:
			return g

#############################################################################################

# Verifica se um numero e primo utilizando o metodo de Miller-Rabin. Sendo este um metodo probabilistico, 
#	segundo o ANSI (1998) tem-se:
#		- Probabilidade de um falso positivo: 1/(4^sec)
#		- Erro total do algoritmo: <= 1/(2^100)
#	Recomenda-se que o algoritmo se deva repetir sec >= 50 vezes para que se garantam as margens de erro. 
# Adaptado de ANSI X9-42 (1998)/RFC 2631(1999))
def _checkPrime(num, sec=50):

	if sec < 50:
		print("Security parameter must be valued with at least (+)50. Exiting.")
		sys.exit(1)

	if num < 2 or _checkParity(num):
		return False

	if num == 2:
		return True

	if num % int(math.floor(num)) != 0: # no caso de não ser inteiro
		return False

	# Encontrar inteiros a>0 e d impar tal que r = 1 + 2^a * d. Isto faz com que r - 1 = 2^a*d, logo tenta-se 
	#	encontrar o primeiro numero impar e incrementar o "a" tal que satisfaca a equacao.
	a = 0
	d = num - 1

	while d % 2 == 0:
		a += 1
		d >>= 1 # o mesmo que dividir d por 2 e obter a parte inteira, ou seja, d = math.floor(d / 2),
				#	ou ainda d //= 2


	for i in range(0,sec):
		#Gerar aleatoriamente um inteiro b no intervalo ]1,r[
		b = random.SystemRandom().randint(2,num-1)
		z = pow(b,d,num)
		
		if z == 1 or z == num-1:
			continue

		for j in range(0,a):
			z = pow(z,2,num) # repete "a" vezes esta conta se nao for primo, repete j vezes se for

			if z == num-1:
				break
		else:
			return False # se o ciclo acabou e porque nao e primo
	
	return True

##############################################################################################

# Verifica paridade de um numero
def _checkParity(num):
	return True if num % 2 == 0 else False

###############################################################################################

# VALORES PARA CONEXAO MANUAL

if __name__ == "__main__":
	values = DHInitialValues()
	print(str(values).strip('()').replace(" ", ""))

	connect = input("Token e B: ")
	connect = connect.strip().split(',')
	key = DHGetSecret(values[1], int(connect[1]))
	print(key)
	encmsg = encrypt(key, "READ " + connect[0])
	print(encmsg)