# coding=utf-8
# LABI-P2-G1

import db

def test_getUser():
	assert db.getUser("dias.eurico") != '[]'
	assert db.getUser("qwerty123456789aAaAAa") == '[]'
	assert db.getUser("") == '[]'

def test_getUserId():
	assert db.getUserId("equipa") != None
	assert db.getUserId("dias.eurico") in [2, "2"]
	assert db.getUserId("qwertyiwantthistofail1234554321") == None
	assert db.getUserId("") == None

def test_getUserNumVotes():
	assert db.getUserNumVotes("dias.eurico") != '[]'
	assert db.getUserNumVotes("qwerty123456789aAaAAa") == None
	assert db.getUserNumVotes("") == None

def test_getSongs():
	assert db.getSongs() != "DATABASE_ERROR"

def test_getSonggen():
	assert db.getSonggen("8434efc3978369c2") != '[]'
	assert db.getSonggen("INVALIDHASHID") == None
	assert db.getSonggen("") == None

def test_getSamples():
	assert db.getSamples() != "DATABASE_ERROR"

def test_getEffects():
	assert db.getEffects() != "DATABASE_ERROR"

def test_getVotesUser():
	#assert db.getVotesUser("equipa") != '[]'
	assert db.getVotesUser("r.rosmaninho") != '[]'
	assert db.getVotesUser("qwerty123456789aAaAAathisusernamedoesnotexist") == '[]'
	assert db.getVotesUser("") == '[]'

def test_getSongsOrdered():
	assert db.getSongsOrdered("votes", "one") == "PARAM_ERROR"
	assert db.getSongsOrdered("votos", 0) != '[]'
	assert db.getSongsOrdered("votes", 1) != '[]'
	assert db.getSongsOrdered("votes", 999) != '[]'
	assert db.getSongsOrdered("votes", -7) != '[]'
	assert db.getSongsOrdered("uses", 1) != '[]'
	assert db.getSongsOrdered("usos", 0) != '[]'
	assert db.getSongsOrdered("nonexistentcolumn", 1) != '[]' # porque o campo selecionado é a data quando o do argumento não existe

def test_getSamplesOrdered():
	assert db.getSamplesOrdered("votes", "one") == "PARAM_ERROR"
	assert db.getSamplesOrdered("votos", 0) != '[]'
	assert db.getSamplesOrdered("votes", 1) != '[]'
	assert db.getSamplesOrdered("votes", 888) != '[]'
	assert db.getSamplesOrdered("votes", -11) != '[]'
	assert db.getSamplesOrdered("uses", 1) != '[]'
	assert db.getSamplesOrdered("usos", 0) != '[]'
	assert db.getSamplesOrdered("nonexistentcolumn", 1) != '[]'

def test_getVotesByHashid():
	assert db.getVotesByHashid("8434efc3978369c2") != '[]'
	assert db.getVotesByHashid("INVALIDHASHID") == "ELEMENT_NOT_EXISTENT"
	assert db.getVotesByHashid("") == "ELEMENT_NOT_EXISTENT"

def test_getPathByHashid():
	assert db.getPathByHashid("8434efc3978369c2") != None
	assert db.getPathByHashid("INVALIDHASHID") == None
	assert db.getPathByHashid("") == None

def test_getAvatar():
	assert db.getAvatar("equipa") != None
	assert db.getAvatar("qwerty123456789aAaAAathisusernamedoesnotexist") == None
	assert db.getAvatar("") == None