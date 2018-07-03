#coding=utf-8
# LABI P2-G1


from PIL import Image
import os
import json
import db

# gera a imagem da pauta (matriz representativa da músiaca)
def makeScore(hashid):
	try:
		jscore = json.loads(db.getSonggen(hashid))
		music = jscore["music"]
		samples = jscore["samples"]
		print("music(x):", music)
		print("sample(y):", samples)
		
		tile_len = 52 # música representada por um mosaico com "azulejos" de lado 52 (pode ser mudado), incluindo bordas

		width = tile_len * len(music) # largura variável, depende do número de colunas usadas (últimas não usadas não são contadas)
		height = tile_len * len(samples) # altura variável, depende do número de samples a ser usadas

		#criação da imagem, com fundo branco
		image = Image.new("RGB", (width, height,))

		#passar por todos os pixeis da imagem
		for y in range(height):
			tile_y = y % tile_len # coordenada y dentro de cada tile
			for x in range(width):
				tile_x = x % tile_len # coordenada x dentro de cada tile

				if 0 <= tile_x <= 1 or tile_len-2 <= tile_x <= tile_len-1: # representa a borda vertical em x = x0
					pcolor = (0, 0, 0,) # pixel preto
				elif 0 <= tile_y <= 1 or tile_len-2 <= tile_y <= tile_len-1: # representa a borda horizontal em y = y0
					pcolor = (0, 0, 0,) # pixel preto
				else:
					if int(y // tile_len) in music[x // tile_len]: # a sample está selecionada no azulejo 
						pcolor = (0, 90, 255,) # pixel azul
					else: # se não houver sample no azulejo
						pcolor = (255, 255, 255,) # pixel branco

				image.putpixel((x, y,), pcolor)
		return image
	except IOError:
		return 'FILE_ERROR'