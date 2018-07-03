#coding=utf-8
#Labi-2018 P2G1

## Funções de queries à base de dados SQLite3 'proj2.db'
import sqlite3 as sql
import json
import marshal
import base64

#modelar "resultsets" da query à DB num dicionário para conversão direta em JSON
def toDict(cursor, row):
	message = {}
	for i, column in enumerate(cursor.description):
		message[column[0]] = row[i]
	return message

def getUser(user):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('SELECT * FROM users WHERE email = ?', (user,)).fetchall()
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getUserId(user):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('SELECT userid FROM users WHERE email = ?', (user,)).fetchone()
		if data == None:
			return None
		return data["userid"]
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getUserNumVotes(user):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('SELECT numvotes FROM users WHERE email = ?', (user,)).fetchone()
		print("DEBUG: " + str(data))
		return data
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getSongs():
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()
		data = c.execute('''SELECT s.name AS name, sg.songhid AS id, s.date AS date, s.uses AS uses, s.path AS path, s.votes AS votes, u.email as author
							 FROM songs AS s, users AS u, songgen AS sg
							 WHERE s.authorid = u.userid AND s.songhid = sg.songhid''').fetchall()
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getSonggen(hashid):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('''SELECT bpm, samples, effects, music FROM songgen
							WHERE songhid = ?''', (hashid,)).fetchone()

		if data == None:
			return None
		data["samples"] = marshal.loads(data["samples"])
		data["effects"] = marshal.loads(data["effects"])
		data["music"] = marshal.loads(data["music"])

		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'


def getSamples():
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()
		result = c.execute('''SELECT s.name AS name, s.samplehid AS id, s.date AS date, s.uses AS uses, s.path AS path, s.votes AS votes, u.email as author
							 FROM samples AS s, users AS u
							 WHERE s.authorid = u.userid''')
		data = result.fetchall()
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getEffects():
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('SELECT name FROM effects ORDER BY name ASC').fetchall()
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getVotesUser(user):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()
		data = c.execute('''SELECT songhid AS id, type AS vote FROM votes 
							WHERE userid = (SELECT userid FROM users WHERE email = ?)''', (user,)).fetchall()
		
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getSongsOrdered(column, order):
	try:
		order = int(order)
	except ValueError:
		return 'PARAM_ERROR'

	if column == 'votos' or column == 'votes':
		column = 'votes'
	elif column == 'usos' or column == 'uses':
		column = 'uses'
	elif column == 'date' or column == 'data': 
		column = 'date'
	else:
		column = 'name'

	if order == 0:
		order = 'ASC'
	else:
		order = 'DESC'

	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('''SELECT s.name AS name, s.songhid AS id, s.date AS date, s.uses AS uses, s.path AS path, s.votes AS votes, u.email AS author
					 		 FROM songs AS s
					 		 LEFT JOIN users AS u ON s.authorid = u.userid ORDER BY s.''' + column + " " + order).fetchall()
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getSamplesOrdered(column, order):

	try:
		order = int(order)
	except ValueError:
		return 'PARAM_ERROR'

	if column == 'votos' or column == 'votes':
		column = 'votes'
	elif column == 'usos' or column == 'uses':
		column = 'uses'
	elif column == 'data' or column == 'date': 
		column = 'date'
	else:
		column = 'name'

	if order == 0:
		order = 'ASC'
	else:
		order = 'DESC'

	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = c.execute('''SELECT s.name AS name, s.samplehid AS id, s.date AS date, s.uses AS uses, s.path AS path, s.votes AS votes, u.email AS author
					 		 FROM samples AS s
					 		 LEFT JOIN users AS u ON s.authorid = u.userid ORDER BY s.''' + column + " " + order).fetchall()
		c.close()
		return json.dumps(data)
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getVotesByHashid(hashid):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		votes = db.execute('SELECT votes FROM songs WHERE songhid = ?', (hashid,)).fetchone()
		if votes is None:
			votes = db.execute('SELECT votes FROM samples WHERE samplehid = ?', (hashid,)).fetchone()
			if votes is None:
				return 'ELEMENT_NOT_EXISTENT'
		return votes
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def getPathByHashid(hashid):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		path = db.execute('SELECT path FROM songs WHERE songhid = ?', (hashid,)).fetchone()
		if path is None:
			path = db.execute('SELECT path FROM samples WHERE samplehid = ?', (hashid,)).fetchone()
		return path
	except sql.DatabaseError:
		return 'DATABASE_ERROR'
		
def getAvatar(user):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		avatar = c.execute('SELECT avatar FROM users WHERE email = ?', (user,)).fetchone()
		return avatar
	except sql.DatabaseError:
		return 'DATABASE_ERROR'


def setReport(user, elemhid):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		c.execute('''INSERT INTO reports (userid, elemhid)
					 VALUES ((SELECT userid FROM users WHERE email = ?), ?)''', (user, elemhid,))

		db.commit()
		c.close()

		return 'OK'
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def setSonggen(jvar):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		data = json.loads(jvar)

		data['samples'] = marshal.dumps(data['samples'])
		data['effects'] = marshal.dumps(data['effects'])
		data['music'] = marshal.dumps(data['music'])

		verif = c.execute('SELECT songhid FROM songgen WHERE songhid = ?', (data["songhid"],)).fetchone()
		if verif is None:
			c.execute('''INSERT INTO songgen ''' +  str(tuple(data.keys())) + '''
						 VALUES (?, ?, ?, ?, ?)''', tuple(data.values()))
			db.commit()
		else:
			return 'SCORE_EXISTS'
		c.close()
	except json.JSONDecodeError:
		return 'JSON_PARSING_ERROR'
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def setUses(elemhid):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		verif = c.execute('SELECT songhid FROM songs WHERE songhid = ?', (elemhid,)).fetchone()
		if verif is None:
			verif = c.execute('SELECT samplehid FROM samples WHERE samplehid = ?', (elemhid,)).fetchone()
			if verif is None:
				return 'ELEMENT_NOT_EXISTENT'
			else:
				c.execute('UPDATE samples SET uses = uses + 1 WHERE songhid = ?', (elemhid,))
		else:
			c.execute('UPDATE songs SET uses = uses + 1 WHERE samplehid = ?', (elemhid,))

		db.commit()
		c.close()
	except sql.DatabaseError:
		return 'DATABASE_ERROR'


def setSong(jvar):
	#try:
	db = sql.connect('proj2.db')
	db.row_factory = toDict
	c = db.cursor()
	data = json.loads(jvar)

	verif = c.execute('SELECT songhid FROM songs WHERE songhid = ?', (data["songhid"],)).fetchone() # ver se já existe um registo para aquele id
	if verif == None:
		userid = c.execute('SELECT userid FROM users WHERE email = ?', (data["authorid"],)).fetchone()
		keytuple = str(tuple(data.keys()))
		del data["authorid"]
		c.execute('''INSERT INTO songs''' + keytuple + '''
						VALUES (?, ?, ?, ?)''', (userid["userid"],) + tuple(data.values()))
		db.commit()
		c.close()
	else:
		return 'SONG_EXISTS'

	"""except json.JSONDecodeError:
		return 'JSON_PARSING_ERROR'
	except sql.DatabaseError:
		return 'DATABASE_ERROR'"""

def setUser(jvar):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()
		
		data = json.loads(jvar)

		verif = c.execute('SELECT userid FROM users WHERE email = ?', (data['email'],)).fetchone()
		if verif is None:
			c.execute('''INSERT INTO users ''' + str(tuple(data.keys())) + '''
						  VALUES (?, ?, ?, ?)''', tuple(data.values()))
			db.commit()
			c.close()
		else:
			return 'USER_EXISTS'
	except json.JSONDecodeError:
		return 'JSON_PARSING_ERROR'
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def setSample(jvar):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		print(str(jvar))
		data = json.loads(jvar)

		bodge = '''INSERT INTO samples ''' + str(tuple(data.keys())) + '''
						VALUES ''' + str(tuple(data.values()))

		c.execute(bodge)
		db.commit()
		c.close()
	except sql.DatabaseError:
		return 'DATABASE_ERROR'
	except json.JSONDecodeError:
		return 'JSON_PARSING_ERROR'


# Insere um voto de um utilizador num elemento na base de dados
def setVoteElement(table, hashid, user, votetype):
	tablevalues = ['songs', 'songgen', 'samples']

	# averiguar se a tabela passada é válida
	if table not in tablevalues:
		return 'PARAM_ERROR'

	# obter o nome da coluna do hash do elemento
	if table == 'samples':
		namehid = 'samplehid'
	else:
		namehid = 'songhid'

	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		#verificar que voto não existe
		verif = c.execute('SELECT * FROM votes WHERE songhid = ? AND userid = (SELECT userid FROM users WHERE email = ?)', (hashid, user,)).fetchone()
		if verif is None:
			
			#inserir o voto na tabela votes
			c.execute('''INSERT INTO votes (songhid, userid, type) 
							VALUES (?, (SELECT userid FROM users WHERE email = ?), ?)''', (hashid, user, votetype,))
			#fazer update ao número de votos do elemento
			c.execute('''UPDATE ''' + table + ''' SET votes = votes + (?)
							WHERE ''' + namehid + ''' = ?''', (votetype, hashid,))

			#fazer update ao número de votos do utilizador criador do elemento
			c.execute('''UPDATE users SET numvotes = numvotes + (?) 
							WHERE userid = 
							(SELECT authorid FROM ''' + table + ''' WHERE ''' + namehid + ''' = ?)''', (votetype, hashid,))

			db.commit()
			c.close()
		else:
			return 'USER_ALREADY_VOTED'
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def deleteVoteElement(table, hashid, user):

	tablevalues = ['songs', 'samples']

	# averiguar se a tabela passada é válida
	if table not in tablevalues:
		return 'PARAM_ERROR'

	# obter o nome da coluna do hash do elemento
	if table == 'samples':
		namehid = 'samplehid'
	else:
		namehid = 'songhid'

	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		#verificar que voto existe
		verif = c.execute('SELECT userid FROM votes WHERE songhid = ?', (hashid,)).fetchone()
		if verif is not None:
			# utilizador criador do elemento
			userid = c.execute('SELECT authorid FROM ' + table + ' WHERE ' + namehid + ' = ?', (hashid,)).fetchone()['authorid']
			# tipo de voto (positivo ou negativo)
			votetype = c.execute('SELECT type FROM votes WHERE userid = (SELECT userid FROM users WHERE email = ?) AND songhid = ?', (user, hashid,)).fetchone()['type']

			# remover o voto
			c.execute('''DELETE FROM votes 
						 WHERE userid =
						(SELECT userid FROM users WHERE email = ?) AND songhid = ?''', (user, hashid,))

			#fazer update ao número de votos do elemento
			c.execute('''UPDATE ''' + table + ''' SET votes = votes - ?
						 WHERE ''' + namehid + ''' = ?''', (votetype, hashid,))

			#fazer update ao número de votos do utilizador criador do elemento
			c.execute('''UPDATE users SET numvotes = numvotes - ? 
						WHERE userid = ?''', (votetype, userid,))
			db.commit()

			c.close()
		else:
			return 'NO_VOTE_TO_DELETE'
	except sql.DatabaseError:
		return 'DATABASE_ERROR'

def setAvatar(user, path):
	try:
		db = sql.connect('proj2.db')
		db.row_factory = toDict
		c = db.cursor()

		c.execute('UPDATE users SET avatar = ? WHERE email = ?', (path, user,))
		db.commit()

		c.close()
	except sql.DatabaseError:
		return 'DATABASE_ERROR'