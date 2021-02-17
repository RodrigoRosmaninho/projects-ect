// Código fonte do projeto P2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
// Projeto: http://code.ua.pt/projects/labi2018-p2-g1

// Grupo #1
// NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
// NMEC: 72783  NOME: Eurico Dias         TURMA: P5
// NMEC: 89140  NOME: João Trindade       TURMA: P5
// NMEC: 88734  NOME: Pedro Valério       TURMA: P5


// ############################################
//  Fazer GET REQUEST a '/user' para obter o utilizador universal (UU) da pessoa que está a utilizar o website
//  Alterar o elemento '#user' da página HTML para mostrar o UU do utilizador na navbar

var user = "";
var xmlHttp = new XMLHttpRequest();
xmlHttp.onreadystatechange = function() { 
    if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        document.getElementById("user").innerHTML = xmlHttp.responseText;
        user = xmlHttp.responseText;
    }
}
xmlHttp.open("GET", "user", true);
xmlHttp.send(null);
