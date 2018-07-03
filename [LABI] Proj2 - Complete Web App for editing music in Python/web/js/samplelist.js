// Código fonte do projeto P2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
// Projeto: http://code.ua.pt/projects/labi2018-p2-g1

// Grupo #1
// NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
// NMEC: 72783  NOME: Eurico Dias         TURMA: P5
// NMEC: 89140  NOME: João Trindade       TURMA: P5
// NMEC: 88734  NOME: Pedro Valério       TURMA: P5


// ############################################
//  Fazer GET REQUEST a '/list?type=samples' para obter um objeto JSON com a lista de todos os excertos existentes.
//  ...

var list = "";
var json_data = "";

function init_list() {
    var song_list_request = new XMLHttpRequest();
    song_list_request.onreadystatechange = function () {
        if (song_list_request.readyState == 4 && song_list_request.status == 200) {
            json_data = JSON.parse(song_list_request.responseText);

            list = "";
            var page = 0;
            for (var i = 0; i < json_data.length; i++) {
                song_data = json_data[i];
                if (i % 10 == 0) page++;
                list = list + `
            <tr class="song page` + page + `">
                <td style="padding-right: 0px;">
                    <div class="votes">
                        <i class="fa fa-arrow-up upvote" id="upvote-` + song_data.id + `" onclick="upvote('` + song_data.id + `')"></i><br>
                        <span class="label label-primary votos" id="votos-` + song_data.id + `">` + song_data.votes + `</span><br>
                        <i class="fa fa-arrow-down downvote" id="downvote-` + song_data.id + `" onclick="downvote('` + song_data.id + `')"></i>
                    </div>
                </td>
                <td style="padding-top: 40px; padding-left: 0px; padding-right: 0px;">
                    <div class="uses">
                        <span class="label label-primary"><b>` + song_data.uses + `</b></span><br>usos
                    </div>
                </td>
                <td style="padding-top: 25px; padding-left: 0px; padding-right: 0px;">
                    <a class="song-name">` + song_data.name + `</a>
                    <br>
                    <audio controls>
                        <source src="get/?id=` + song_data.path + `" type="audio/mpeg"> Your browser does not support the audio element.
                    </audio>
                </td>
                <td style="padding-top: 15px; padding-left: 0px; padding-right: 0px;">
                    <a>
                        <img class="avatar" src="avatar/?id=` + song_data.author + `"></img>
                    </a>
                    <br>
                    <a class="user-` + song_data.author + ` user-link" href="#" data-content="Karma: 0" rel="popover" data-placement="bottom" data-original-title="` + song_data.author + `">` + song_data.author + `</a>
                </td>
                <td style="padding-top: 25px; padding-left: 0px;">
                    <button class="report-` + song_data.author + ` report_sample btn btn-danger" style="margin-bottom: 15px;" onclick="report(` + song_data.id + `)" type="button">🚫  Reportar</button>
                    <br>
                    <a>` + handleDate(song_data.date) + `</a>
                </td>
            </tr>`;

                getKarma(song_data.author);
            }

            document.getElementById("list").innerHTML = list;
            $('.user-link').popover({ trigger: "hover" });
            getVotes("", 2);
            getAdmins();
            setPagination(page);
        }
    }
    var url = new URL(window.location.href);
    var order = url.searchParams.get("order");
    var a_d = url.searchParams.get("asc_desc");
    if (a_d == 0) document.getElementById("asc_radio").checked = true;
    else if (a_d == null) a_d = 0;
    if (order != null) {
        song_list_request.open("GET", "list/?type=samples&order=" + order + "&asc_desc=" + a_d, true);
        if (order == "votos") document.getElementById("dropdownMenuButton").innerHTML = "Nº de votos";
        else document.getElementById("dropdownMenuButton").innerHTML = "Nº de usos";
    }
    else song_list_request.open("GET", "list/?type=samples&asc_desc=" + a_d, true);
    song_list_request.send(null);
}


function updateVotes(id) {
    var single_votes_request = new XMLHttpRequest();
    single_votes_request.onreadystatechange = function () {
        if (single_votes_request.readyState == 4 && single_votes_request.status == 200) {
            json_data2 = JSON.parse(single_votes_request.responseText);
            var v = json_data2.votes;
            votos = document.getElementById("votos-" + id);
            if(votos != null) votos.innerHTML = v;
        }
    }
    single_votes_request.open("GET", "getVotes/?id=" + id, true);
    single_votes_request.send(null);
}

function getVotes(id, mode) {
    var votes_list_request = new XMLHttpRequest();
    votes_list_request.onreadystatechange = function () {
        if (votes_list_request.readyState == 4 && votes_list_request.status == 200) {
            json_data = JSON.parse(votes_list_request.responseText);

            for (var i = 0; i < json_data.length; i++) {
                votes_data = json_data[i];
                up = document.getElementById("upvote-" + votes_data.id)
                down = document.getElementById("downvote-" + votes_data.id)

                if (up != null && down != null) {
                    if (votes_data.vote == 1) {
                        up.style.color = "#f5511d";
                        down.style.color = "";
                    }
                    else if (votes_data.vote == -1) {
                        up.style.color = "";
                        down.style.color = "#5742c1";
                    }
                }
            }
            if (mode == 1) upvote(id);
            else if (mode == -1) downvote(id);
            if (mode != 2) updateVotes(id);
        }
    }
    votes_list_request.open("GET", "list/?type=votes", true); // true for asynchronous 
    votes_list_request.send(null);
}

function upvote(id) {
    var vote_value = 0;
    var exists = false;
    for (var i in json_data) {
        if (json_data[i].id === id) {
            vote_value = json_data[i].vote;
            exists = true;
            break;
        }
        else exists = false;
    }

    if (!exists) {
        var upvote_request = new XMLHttpRequest();
        upvote_request.onreadystatechange = function () {
            if (upvote_request.readyState == 4 && upvote_request.status == 200) {
                getVotes(id, 0);
            }
        }
        upvote_request.open("POST", "vote/?id=" + id + "&user=" + user + "&points=1&type=samples", true); // true for asynchronous 
        upvote_request.send(null);
    }
    else {
        document.getElementById("upvote-" + id).style.color = "";
        document.getElementById("downvote-" + id).style.color = "";
        if (vote_value == -1) unvote(id, 1)
        else unvote(id, 0);
    }
}

function unvote(id, mode) {
    var unvote_request = new XMLHttpRequest();
    unvote_request.onreadystatechange = function () {
        if (unvote_request.readyState == 4 && unvote_request.status == 200) {
            getVotes(id, mode);
        }
    }
    unvote_request.open("POST", "vote/?id=" + id + "&user=" + user + "&points=0&type=samples", true); // true for asynchronous 
    unvote_request.send(null);
}

function downvote(id) {
    var vote_value = 0;
    var exists = false;
    for (var i in json_data) {
        if (json_data[i].id === id) {
            vote_value = json_data[i].vote;
            exists = true;
            break;
        }
        else exists = false;
    }

    if (!exists) {
        var upvote_request = new XMLHttpRequest();
        upvote_request.onreadystatechange = function () {
            if (upvote_request.readyState == 4 && upvote_request.status == 200) {
                getVotes(id, 0);
            }
        }
        upvote_request.open("POST", "vote/?id=" + id + "&user=" + user + "&points=-1&type=samples", true); // true for asynchronous 
        upvote_request.send(null);
    }
    else {
        document.getElementById("upvote-" + id).style.color = "";
        document.getElementById("downvote-" + id).style.color = "";
        if (vote_value == 1) unvote(id, -1)
        else unvote(id, 0);
    }
}

function handleDate(str) {
    timestamp = str.split(" ");
    date = timestamp[0].split("-");

    ddmmyyyy = date[2] + "/" + date[1] + "/" + date[0];
    hhmm = timestamp[1].substring(0, timestamp[1].length - 10);

    //return hhmm + " - " + ddmmyyyy;
    return ddmmyyyy + " - " + hhmm;
}

function getAdmins() {
    var admin_request = new XMLHttpRequest();
    admin_request.onreadystatechange = function () {
        if (admin_request.readyState == 4 && admin_request.status == 200) {
            admins = JSON.parse(admin_request.responseText);
            for (i in admins) {
                var dom1 = document.getElementsByClassName("user-" + admins[i]);
                var dom2 = document.getElementsByClassName("report-" + admins[i]);
                if (dom1 != null) {
                    for (d in dom1) {
                        dom1[d].innerHTML = admins[i] + " " + "<img class=\"admin-ico\" style=\"width: 14px; height: 14px; \" src=\"/web/static/admin.png\"></img>";
                        dom2[d].disabled = true;
                    }
                }
            }
        }
    }
    admin_request.open("GET", "admins", true); // true for asynchronous 
    admin_request.send(null);
}

function changeSort(sort) {
    var radios = document.getElementsByName('asc_desc');
    var asc_desc = 0;

    for (var i = 0, length = radios.length; i < length; i++) {
        if (radios[i].checked) {
            asc_desc = radios[i].value;
            break;
        }
    }

    if (sort != undefined) window.location.replace("samples?order=" + sort + "&asc_desc=" + asc_desc);
    else window.location.replace("samples?asc_desc=" + asc_desc);
}

function setPagination(page_num) {
    $('#paginacao').twbsPagination({
        totalPages: page_num,
        // the current page that show on start
        startPage: 1,

        // maximum visible pages
        visiblePages: page_num,

        initiateStartPageClick: true,

        // template for pagination links
        href: false,

        // variable name in href template for page number
        hrefVariable: '{{number}}',

        // Text labels
        first: 'Primeira',
        prev: 'Anterior',
        next: 'Próxima',
        last: 'Última',

        // carousel-style pagination
        loop: false,

        // callback function
        onPageClick: function (event, page) {
            $('.page-active').removeClass('page-active');
            $('.page' + page).addClass('page-active');
        },

        // pagination Classes
        paginationClass: 'pagination',
        nextClass: 'next',
        prevClass: 'prev',
        lastClass: 'last',
        firstClass: 'first',
        pageClass: 'page',
        activeClass: 'active',
        disabledClass: 'disabled'

    });
}

function update_upload_label() {
    var f = document.getElementById("sample_upload").value.split("\\");
    document.getElementById("sample_upload_label").innerHTML = f[f.length - 1];
}

function report(id) {
    var report_request = new XMLHttpRequest();
    report_request.onreadystatechange = function () {
        if (report_request.readyState == 4 && report_request.status == 200) {
            resposta = report_request.responseText;
            if(resposta == "OK") alert("A equipa foi avisada. Obrigado.");
            else alert("Ocorreu um erro!");
        }
    }
    report_request.open("GET", "/report/?id=" + id, true);
    report_request.send(null);
}

function getKarma(user) {
    var karma_request = new XMLHttpRequest();
    karma_request.onreadystatechange = function () {
        if (karma_request.readyState == 4 && karma_request.status == 200) {
            res =  JSON.parse(karma_request.responseText)['numvotes'];
            arr = document.getElementsByClassName("user-" + user);

            for (var key in arr) {
                arr[key].setAttribute("data-content", "Karma: " + res);
            }
        }
    }
    karma_request.open("GET", "/getKarma/?user=" + user, true);
    karma_request.send(null);
}

init_list();
