#coding=utf-8

# Código fonte do projeto AP2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
# Projeto: http://code.ua.pt/projects/labi2018-ap2-g3

# Grupo #3
# NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
# NMEC: 72783  NOME: Eurico Dias         TURMA: P5

# TODO: Adicionar a estes comentários preliminares uma descrição do objetivo deste ficheiro

import sys

if sys.platform == "win32" or sys.platform == "cygwin":
    try:
        # Importar método colorama para que as cores funcionem em Windows
        import colorama
        colorama.init()
    except ImportError:
        print("## Nota: Em Windows é necessário executar previamente 'pip install colorama' para que sejam apresentadas cores. ##")

HEADER = '\033[95m'
OKBLUE = '\033[94m'
OKGREEN = '\033[92m'
WARNING = '\033[93m'
FAIL = '\033[91m'
ENDC = '\033[0m' # ENDC faz com que as cores voltem ao normal
BOLD = '\033[1m'
sUNDERLINE = '\033[4m'

def header(s):
    return HEADER + s + ENDC

def okblue(s):
    return OKBLUE + s + ENDC

def okgreen(s):
    return OKGREEN + s + ENDC

def warning(s):
    return WARNING + s + ENDC

def fail(s):
    return FAIL + s + ENDC

def bold(s):
    return BOLD + s + ENDC

def underline(s):
    return sUNDERLINE + s + ENDC