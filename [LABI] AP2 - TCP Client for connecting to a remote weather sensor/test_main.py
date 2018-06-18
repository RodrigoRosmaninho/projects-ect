#coding=utf-8

# Código fonte do projeto AP2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-ap2-g3

# Grupo #3
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5

import pytest
from main import isValidJSON, readJSON, hasError

VALID_JSON_1 = "{ \"type\" : \"OK\" }"
VALID_JSON_2 = "{ \"object\" : " + VALID_JSON_1 + " }"
INVALID_JSON_1 = VALID_JSON_1[:-1]
INVALID_JSON_2 = "{ type : \"OK\" }"
INVALID_JSON_3 = ""

DICT_1 = { "type" : "OK" }
DICT_2 = { "object" :  DICT_1 }
DICT_3 = { "content" : "Invalid message: teste", "type" : "ERROR" }
DICT_4 = { "content" : "Invalid message: teste2", "type" : "NOT ERROR" }

def test_isValidJSON():
    assert isValidJSON(VALID_JSON_1) == True
    assert isValidJSON(VALID_JSON_2) == True
    assert isValidJSON(INVALID_JSON_1) == False
    assert isValidJSON(INVALID_JSON_2) == False
    assert isValidJSON(INVALID_JSON_3) == False

def test_readJSON():
    assert readJSON(VALID_JSON_1) == DICT_1
    assert readJSON(VALID_JSON_2) == DICT_2

def test_hasError():
    assert hasError(DICT_1) == False
    assert hasError(DICT_2) == False
    assert hasError(DICT_3) == True
    assert hasError(DICT_4) == True


