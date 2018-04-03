// Rodrigo Rosmaninho e Jorge C. Silva - UA 2018

/* Este código serve para gerir o questionário
  As perguntas e respostas estão no ficheiro js/perguntas.json
  São escolhidas aleatóriamente 7 das 22 perguntas

  Exemplo de como um conjunto pergunta/respostas é guardado no ficheiro js/perguntas.json

    {
        "resposta": 0, <-- Índice (0 a 3) da resposta correta
        "opcoes": [ <-- Array de respostas possíveis
          "resposta 1",
          "resposta 2",
          "resposta 3",
          "resposta 4"
        ],
        "pergunta": "pergunta exemplo 17" <-- pergunta
      }
*/

var arr;
var perguntas;

function começarQuiz(){
    document.getElementById("submit").innerHTML = "<button type=\"button\" class=\"btn btn-primary\" onclick=\"validarRespostas()\">Terminar</button>"; // Trocar botão 'começar' por 'terminar'

    var request = new XMLHttpRequest();
    request.open('GET', 'js/perguntas.json'); // buscar ficheiro perguntas.json (onde estão as perguntas e respostas)
    request.responseType = 'json';
    request.send();

    request.onload = function() {
        perguntas = request.response; // guardar array de perguntas e respostas numa variável
        var questionario = ""; // variável que vai conter todo o HTML do questionário

        arr = gerarAleatorio(perguntas[0].numDePerguntas); // chamar a função gerarAleatorio com o número total de perguntas como argumento e guardar o array devolvido na variável arr

        for(var i = 0; i < 7; i++){
            var escolhaMultipla = ""; // variável que vai conter todo o HTML das respostas de uma determinada pergunta
            for(var x = 0; x < 4; x++){
                escolhaMultipla += "<div class=\"form-check\" id=\"div" + arr[i] + "_" + x + "\"><label class=\"form-check-label\"><input class=\"form-check-input\" type=\"radio\" name=\"radio" + arr[i] + "\" id=\"radio" + arr[i] + "_" + x + "\" value=" + x + ">" + perguntas[arr[i]].opcoes[x] + "</label></div>";
            }
            questionario += "<br><h3>" + perguntas[arr[i]].pergunta + "</h3><br>" + escolhaMultipla; // adicionar a pergunta e o HTML das respostas ao HTML do questionário, guardado na variável questionário
        }
        document.getElementById("quizDiv").innerHTML = questionario; // adicionar o HTML do questionário à página através da div "quizDiv"
    }
}


function gerarAleatorio(n){
    var arr = []; // array que vai conter os índices das perguntas aleatoriamente escolhidas
    for(var i = 0; i < 7; i++){ // correr o código seguinte 7 vezes, de forma a escolher 7 das perguntas no ficheiro perguntas.json
        while(true){ // necessário para que o código corra até que seja encontrado um número aleatório que ainda não tenha sido contemplado
            var tmp = parseInt(Math.random() * n) + 1; // gerar um número inteiro de 0 a n, onde n é o número de perguntas presentes no ficheiro perguntas.json
            if(i == 0){ // se é a primeira vez que o ciclo corre
                arr[0] = tmp; // guardar número gerado no primeiro índice do array
                break;
            }

            else if(!(averiguarDuplicado(arr, tmp, i))){ // se não é a primeira vez, averiguar se o número aleatório ainda não foi escolhido, chamando a função averiguarDuplicado
                arr[i] = tmp; // se o número escolhido ainda não estava no array, adicioná-lo
                break;
            }
        }
    }

    return arr; // devolver o array
}

function averiguarDuplicado(arr, tmp, i){ // função que verifica se um número já está num array (ambos passados como argumento)
    for(var x = 0; x < i; x++){ // iterar sobre array arr (até ao indice atual, i)
        if(tmp == arr[x]){ // se o número numa determinada posição do array for igual ao último número aleatóriamente escolhido
            return true;
        }
    }

    return false;
}

function validarRespostas(){ // função que verifica e avalia as respostas do utilizador, chamada quando este clica no botão 'terminar'
    for(var i = 0; i < 7; i++){
        for(var x = 0; x < 4; x++){
            document.getElementById('div' + arr[i] + '_' + x).style.color = "black"; // Para todas as perguntas, tornar a cor do texto de cada uma das respostas preto
            // isto é necessário pois se o utilizador tentar submeter o questionário sem ter respondido a uma das perguntas, todas as respostas dessa pergunta ficam vermelhas para salientar qual (ou quais) a pergunta que o utilizador não respondeu
            // assim, após submeter uma segunda vez, todas as respostas devem ficar novamente de cor preta
        }
    }
    
    var mostrarErro;
    var seguroContinuar = true;

    // esta secção (dentro do ciclo for) serve para verificar se o utilizador deixou alguma pergunta sem resposta
    for(var i = 0; i < 7; i++){ // iterar sobre todas as perguntas

        mostrarErro = true;
        for(var x = 0; x < 4; x++){ // iterar sobre todas as respostas de uma determinada pergunta
            if (document.getElementById('radio' + arr[i] + '_' + x).checked) {
                mostrarErro = false; // se alguma das respostas está selecionada, não é necessário mostrar erro
                break;
            }
        }

        if(mostrarErro) { // se o utilizador não respondeu a uma ou mais perguntas (e portanto, mostrarErro está igual a true)
            seguroContinuar = false; // não é seguro continuar com a avaliação das respostas, o utilizador deve primeiro rever o questionário e responder às perguntas em falta
            // todas as respostas da pergunta ficam com cor vermelha para salientar o facto de que a pergunta ficou sem resposta
            document.getElementById('div' + arr[i] + '_0').style.color = "red";
            document.getElementById('div' + arr[i] + '_1').style.color = "red";
            document.getElementById('div' + arr[i] + '_2').style.color = "red";
            document.getElementById('div' + arr[i] + '_3').style.color = "red";
        }

    }

    var numeroDeRespostasCorretas = 0;

    if(seguroContinuar){ // se seguroContinuar é igual a true, ou seja, se o urilizador respondeu a todas as perguntas
        for(var i = 0; i < 7; i++){ // iterar sobre todas as perguntas
            var x = 0;

            for(; x < 4; x++){ // iterar sobre todas as resposta de uma determinada pergunta
                if (document.getElementById('radio' + arr[i] + '_' + x).checked) {
                    break; // quando o ciclo chegar à resposta selecionada, quebrar o ciclo
                    // desta forma, o índice da resposta seguida fica guardado na variável x
                }
            }

            if(x == perguntas[arr[i]].resposta){ // se a variável x é igual à variável resposta dessa pergunta no ficheiro perguntas.json, ou seja, se a resposta selecionada é a resposta correta 
                numeroDeRespostasCorretas++;
                document.getElementById('div' + arr[i] + '_' + x).style.color = "green"; // tornar o texto da resposta selecionada verde
            }

            else{ // se a resposta selecionada está errada
                document.getElementById('div' + arr[i] + '_' + x).style.color = "red"; // tornar o texto da resposta selecionada vermelho
            }
        }

        mostrarResultado(numeroDeRespostasCorretas);
        $('html, body').animate({ scrollTop: $("#substituir").offset().top - 150 }, 'fast'); // ir para o início da página para que o utilizador veja o reultado do questionário
        document.getElementById("submit").innerHTML = ""; // esconder o botão de submeter
    }

    else { // se o utilizador não respondeu a todas as perguntas
        // mostrar erro:
        document.getElementById("substituir").innerHTML = "<div class=\"alert alert-danger\" role=\"alert\"><h4 class=\"alert-heading\">Erro</h4><p>Verifica se respondeste a todas as perguntas convenientemente e submete de novo.</p></div>";
        $('html, body').animate({ scrollTop: $("#substituir").offset().top - 150 }, 'fast'); // ir para o início da página para que o utilizador veja o erro
    }
}

function mostrarResultado(numeroDeRespostasCorretas){ // função para mostrar um alert (bootstrap) com o resultado do questionário
    if(numeroDeRespostasCorretas >= 5) {
        document.getElementById("substituir").innerHTML = "<div class=\"alert alert-success\" role=\"alert\"><h4 class=\"alert-heading\">Muito bem!</h4><p>Respondeste às perguntas e conseguiste acertar <big><b>" + numeroDeRespostasCorretas + " em 7!</big></b><br>Espetacular!</p><hr><p class=\"mb-0\">Se quiseres voltar a tentar, clica <a href=\"quiz.html\">aqui.</a></p></div>";
    }

    else if(numeroDeRespostasCorretas >= 3){
        document.getElementById("substituir").innerHTML = "<div class=\"alert alert-warning\" role=\"alert\"><h4 class=\"alert-heading\">Razoável!</h4><p>Respondeste às perguntas e conseguiste acertar <big><b>" + numeroDeRespostasCorretas + " em 7!</big></b><br>Continua a tentar!</p><hr><p class=\"mb-0\">Se quiseres voltar a tentar, clica <a href=\"quiz.html\">aqui.</a></p></div>";
    }

    else if(numeroDeRespostasCorretas == 0){
        document.getElementById("substituir").innerHTML = "<div class=\"alert alert-danger\" role=\"alert\"><h4 class=\"alert-heading\">Foi fraco :-(</h4><p>Respondeste às perguntas e não conseguiste acertar nenhuma das 7.<br>Volta a ler o conteúdo deste website e tenta de novo!</p><hr><p class=\"mb-0\">Se quiseres voltar a tentar, clica <a href=\"quiz.html\">aqui.</a></p></div>";
    }

    else {
        document.getElementById("substituir").innerHTML = "<div class=\"alert alert-danger\" role=\"alert\"><h4 class=\"alert-heading\">Foi fraco :-(</h4><p>Respondeste às perguntas e conseguiste acertar <big><b>" + numeroDeRespostasCorretas + " em 7!</big></b><br>Volta a ler o conteúdo deste website e tenta de novo!</p></h3><hr><p class=\"mb-0\">Se quiseres voltar a tentar, clica <a href=\"quiz.html\">aqui.</a></p></div>";
    }
}