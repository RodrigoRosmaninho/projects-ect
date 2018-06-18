#coding=utf-8

# Código fonte do projeto AP2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-ap2-g3

# Grupo #3
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5

import base64, pytest, random 
import security

A, p, g = security.DHInitialValues()

b = random.SystemRandom().randint(2,1000000) # valor aleatorio de b
B = pow(g, b, p)


def test_DHInitialValues():

	assert not(A < 0)
	assert A != 0
	assert A != 1
	assert A != 2
	assert A < p

	assert p >= 2

	# tem que ser congruente com o algortimo
	assert g % p != 0
	assert g % p != 1
	assert g % p != p-1
	assert g < p

def test_DHGetSecret():
	assert len(security.DHGetSecret(p, B)) != 0
	assert len(security.DHGetSecret(p, B)) == 32

	assert security.hashKey(pow(A, b, p)) == security.DHGetSecret(p, B)

def test_hashkey():
	assert len(security.hashKey(123123123123123)) > 0
	assert len(security.hashKey(123123123123123)) == 32

	try:
		dummy = int(security.hashKey(123123123123), 16)
	except:
		raise AssertionError("Failed parsing hexadecimal on hashKey().")

def test__unpadJSON():
	assert security._unpadJSON("") == ""
	assert security._unpadJSON("}") == ""
	assert security._unpadJSON("{}123123123") == "{}"
	assert security._unpadJSON("{key: value}1212121212") == "{key: value}"

def test__checkPrime():
	
	assert not security._checkPrime(0)
	assert not security._checkPrime(1)   	  # o 1 nunca pode ser primo
	assert not security._checkPrime(2)        # o 2 e primo
	assert not security._checkPrime(-4)       # testar numeros negativos, estes não podem ser primos
	
	assert not security._checkPrime(12312315) # divisíveis por 5 não podem ser primos
	assert not security._checkPrime(7444437)      # numero que não é primo
	
	assert security._checkPrime(67)           # 67 é primo
	assert security._checkPrime(1049) 		  # 1049 é primo
	assert security._checkPrime(32416190071)  # numero primo grande

def test_encrypt_decrypt():
	
	key = security.hashKey(pow(A, b, p))
	encmsg = base64.b64encode(security.encrypt(key, "{key: value}"))

	assert security.decrypt(key, encmsg) == "{key: value}"

	encmsg = base64.b64encode(security.encrypt(key, ""))
	assert security.decrypt(key, encmsg) == ""