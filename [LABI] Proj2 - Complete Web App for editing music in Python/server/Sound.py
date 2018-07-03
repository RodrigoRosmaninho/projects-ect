# Código fonte do projeto P2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-p2-g1

# Grupo #1
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5
# NMEC: 89140  NOME: João Trindade       TURMA: P5
# NMEC: 88734  NOME: Pedro Valério       TURMA: P5

import db
import struct, os
import sys,wave
from Crypto.Hash import MD5

PATH = os.path.abspath(os.path.dirname("../..")) # raiz do repositório

#devolve o maior comprimento dos arrays dados
#	vals: array de arrays a verificar
def get_highest(vals):
	frames=[]
	for v in vals:
		frames.append(len(v))
		
	high=frames[0]
	
	for f in frames:
		if (f>high):
			high=f
	
	return high

#devolve o valor de x numa funcao linear
#	x: valor de x
#	end: limite do dominio
#	ly: valor minimo (ordenada na origem, se declive positivo)
#	hy: valor maximo (ordenada na origem, se declive negativo)
def linear(x,end,ly,hy):
	k=(hy-ly)/(end)
	return k*x+ly

#devolve o valor de x numa funcao modulo
#	x: valor de x
#	end: limite do dominio
#	ly: valor minimo
#	hy: valor maximo
def branch(x,end,ly,hy):
	if x<end/2:
		return linear(x,end/2,ly,hy)
	else:
		return linear(x-(end/2),end/2,hy,ly)

#cria um de quatro efeitos fade (in,out,inout,outin)
#	data: sample a modificar
#	mode: tipo de fade
def ef_fade(data,mode):
	output=[]
	minval=0.5
	for index,value in enumerate(data):
		if mode=="in":
			output.append(value*linear(index,len(data),minval,1))
		elif mode=="out":
			output.append(value*linear(index,len(data),1,minval))
		elif mode=="inout":
			output.append(value*branch(index,len(data),minval,1))
		elif mode=="outin":
			output.append(value*branch(index,len(data),1,minval))
	if output==[]:
		return ef_volume(data,1)
	return output

#inverte a sample
#	data: sample a modificar
def ef_reverse(data):
	output=[]
	for i in range(len(data)-1,-1,-1):
		output.append(data[i])
	return output

#cria efeito de eco na sample, aumentando a sua duracao por 50%
#	data: sample a modificar
def ef_echo(data):
	output=[]
	rebounds=4
	sounds=[]
	for reb in range(0,rebounds):
		sounds.append(-1)
	for index in range(0,int(len(data)*3/2)):
		som=0
		n=0
		for reb in range(0,len(sounds)):
			if index==reb*int(len(data)/(2*(rebounds-1))):
				sounds[reb]=0
			if (sounds[reb]>=0 and sounds[reb]<len(data)-1):
				n+=1
				som+=(1/(2*reb+1))*data[sounds[reb]]
				sounds[reb]+=1
		if n==0:
			n=1
		output.append(int(som/n))
	return output
			
#aumenta o volume da sample pelo valor especificado
#	data: sample a modificar
#	val: factor a multiplicar
def ef_volume(data,val):
	output=[]
	for index,value in enumerate(data):
		output.append(data[index]*val)
	return output

def init(pauta):
	musicsheet=pauta
	
	rate=44100
	
	samplist=[]
	
	for samp in musicsheet["samples"]:
		samplist.append(db.getPathByHashid(samp))
	
	#parametros
	ntracks=len(musicsheet["samples"])
	beatfreq=60/int(musicsheet["bpm"])
	duration=beatfreq*len(musicsheet["music"])
	nframes=int(duration*rate)
	
	#armazena as samples num array
	wv=[]
	for fin in samplist:
		wv.append(wave.open(os.path.join(PATH, fin['path']),"rb"))
		
	raw_data=[]
	data=[]
	mod_data=[]	
	
	
	
	#escreve os dados dos ficheiros em tuplos de inteiros 
	####################
	
	for i,fin in enumerate(wv):
		fnum=fin.getnframes()
		raw_data.append(fin.readframes(fnum))
		data.append(struct.unpack("%dh"%fnum,raw_data[i]))
		fin.close()
		mod_data.append([])
		
		
	####################
	
	
	
	#criacao de samples mofificadas pelos efeitos especificados
	####################
	
	for i in range(0,ntracks):
		eflist=musicsheet["effects"][i]
		mod_data[i]=ef_volume(data[i],1)
		if len(eflist)>0:
			for ef in eflist:
				if ef=="fadein":
					mod_data[i]=ef_fade(mod_data[i],"in")
				elif ef=="fadeout":
					mod_data[i]=ef_fade(mod_data[i],"out")
				elif ef=="fadeinout":
					mod_data[i]=ef_fade(mod_data[i],"inout")
				elif ef=="fadeoutin":
					mod_data[i]=ef_fade(mod_data[i],"outin")
				elif ef=="reverse":
					mod_data[i]=ef_reverse(mod_data[i])
				elif ef=="echo":
					mod_data[i]=ef_echo(mod_data[i])
	
	####################
	
	
	
	highframes=get_highest(mod_data) #maior length das samples (ver abaixo)
	
	#inicializacao do frame e index de cada sample e dados em bytes
	####################
	
	track_frame=[] #frames de cada sample
	samp_i=[] #o bloco seguinte escreve as tracks frame a frame. Cada sample_i indica qual frame a escrever para cada sample
	wvData=b"" #dados a serem escritos
	
	for i in range(0,ntracks):
		track_frame.append(0) #frame das samples inicializado
		samp_i.append(len(data[i])) #inicializam na length das suas samples para escrever 0s enquanto nao forem utilizadas
		
	####################
	
	
	
	#criacao da musica frame a frame. Em cada frames, e analisada a pauta para determinar se se deve escrever cada uma das samples
	ok=True
	
	for fr in range(0,nframes+highframes): #escreve frame a frame
		som=0 #soma inicializada
		n=0
		for tr in range(0,ntracks):
			
			if (fr%(int(beatfreq*rate))==0) and (fr<nframes): #se o frame corresponder a um inicio de batida
				beat=int(fr/(beatfreq*rate))
				if tr in musicsheet["music"][beat]: #se o array desta batida contiver a sample (identificada por index)
					samp_i[tr]=0 #deve escrever a sample do inicio, comecando neste frame (Nota: se esta sample ainda estivesse a ser escrita seria reiniciada
			
			if samp_i[tr]==len(mod_data[tr]): #se tiver atingido o fim da sample, escreve 0s
				track_frame[tr]=0
			else: #escreve o frame actual da sample e incrementa
				track_frame[tr]=mod_data[tr][samp_i[tr]]
				n+=1
				samp_i[tr]+=1
			
			if n==0:
				n=1
			som+=track_frame[tr] #o frame da faixa actual adicionado a soma
			
		frame=int(som/n) #media do frame fr de cada faixa (conforme a pauta)
		try:
			wvData+=struct.pack("h",int(frame)) #frame resultante adicionado ao resultado final
		except:
			wvData+=struct.pack("h",0) #se ocorrer erro escreve zero por defeito
			ok=False
	
	####################
		
		
		
	#escrita do ficheiro destino
	h=MD5.new()
	h.update(wvData)
	name=h.hexdigest()
	name=name[0:16]
	
	wvOut=wave.open("../songs/"+name+".wav","wb")
	wvOut.setparams((1,2,rate,nframes,"NONE","not compressed"))
	wvOut.writeframes(bytearray(wvData))
	wvOut.close()
	
	return name
