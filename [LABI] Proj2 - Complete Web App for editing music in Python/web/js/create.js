// Código fonte do projeto P2 (2018), desenvolvido no âmbito da UC de Laboratórios de Informática
// Projeto: http://code.ua.pt/projects/labi2018-p2-g1

// Grupo #1
// NMEC: 88802  NOME: Rodrigo Rosmaninho  TURMA: P5
// NMEC: 72783  NOME: Eurico Dias         TURMA: P5
// NMEC: 89140  NOME: João Trindade       TURMA: P5
// NMEC: 88734  NOME: Pedro Valério       TURMA: P5

var samparray = [];
var matriz = [];
var efarray = [];



var row_sample_target = 0;

function getSampById(id) {
	for (var n=0;n<samp_json_data.length;n++) {
		if (samp_json_data[n].id==id) return samp_json_data[n];
	}
}

var samp_json_data = "";
var song_json_data = "";
var effect_json_data = "";

nsamples = 0;

//********************
//INIT FUNCTIONS
//********************

//********************OG
function init_grid() {
	for (var k = 0; k < 12; k++) {
		add_row();
	}
}

//********************REMIX
function init_json(json) {
	document.getElementById("input-bpm").value = json.bpm;
	for (var row = 0; row < json.samples.length; row++) {
		var samp_d = getSampById(json.samples[row]);
		var row_d = fill_row(json.music, row);
		var eff_d = json.effects[row];
		add_row(samp_d,row_d,eff_d);
	}
}

function fill_row(array, n) {
	var result = [];
	var found = false;
	for (var i = 0; i < array.length; i++) {
		found = false;
		for (var j = 0; (j < array[i].length) && (j < 16); j++) {
			if (array[i][j] == n) {
				found = true;
				break;
			}
		}
		if (found) result[result.length] = 1;
		else result[result.length] = 0;
	}
	return result;
}
//********************
//********************



//********************
//TESTING
//********************
function test_json() {
	dic = {
		"bpm": 120,
		"samples": [samp_json_data[0].id, samp_json_data[1].id, samp_json_data[2].id],
		"effects": [[effect_json_data[0].name,effect_json_data[1].name], [effect_json_data[1].name], [effect_json_data[2].name]],
		"music": [[0], [], [0, 1], [2], [0], [1], []]
	}
	document.getElementById("samplelist").innerHTML="";
	document.getElementById("grid").innerHTML = "";
	document.getElementById("effectlist").innerHTML="";
	
	samparray=[];
	matriz = [];
	efarray=[];
	init_json(dic);
}
//********************
//********************

//********************ADD NEW ROW
function add_row(samp_data,row_data,eff_data) {
	var textgrid = document.getElementById("grid").innerHTML;
	var texteff = document.getElementById("effectlist").innerHTML;
	var textsamp = document.getElementById("samplelist").innerHTML;
	var len = matriz.length

	document.getElementById("samplelist").innerHTML = textsamp + get_sampbtn(len);
	if (samp_data==undefined) {	
		samparray[len] = "";
		document.getElementById("samp-btn-" + len).innerHTML = "Excerto";
	}
	else {
		samparray[len] = samp_data.id;
		document.getElementById("samp-btn-" + len).innerHTML = samp_data.name;
	}
	
	if (row_data==undefined) {
		matriz[len] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	}
	else {
		matriz[len] = row_data;
	}
	document.getElementById("grid").innerHTML = textgrid + get_linha(len);
	for (var i = 0; i < len + 1; i++) {
		for (var j = 0; j < 16; j++) {
			reset_celula(i, j);
		}
	}
	if (eff_data==undefined) {
		efarray[len] = [];
		document.getElementById("effectlist").innerHTML = texteff + get_efdd(len,[]);
	}
	else {
		efarray[len] = eff_data;
		document.getElementById("effectlist").innerHTML = texteff + get_efdd(len,eff_data);
		if (efarray[len].length==0) document.getElementById("dd-btn-"+len).style.backgroundColor="#e9ecef";
		else document.getElementById("dd-btn-"+len).style.backgroundColor="#007bff";
	}
	document.getElementById("dd-text-" + len).innerHTML = "Efeitos";
	if (efarray[len].length==0) document.getElementById("dd-btn-"+len).style.backgroundColor="#e9ecef";
	else document.getElementById("dd-btn-"+len).style.backgroundColor="#e9ecef";
}
//********************


//********************
//HTML ADDING FUNCTIONS
//********************
function get_sampbtn(linha) {
	var samps = '<div class="dd-btn">  <button class="btn btn-primary btn-lg dd-btn" type="button" data-toggle="modal" data-target="#sampmod" onclick="set_row_target(' + linha + ')"><spam id="samp-btn-' + linha + '">Sample</spam></button>  </div>';
	return samps;
}

function get_linha(linha) {
	var celulas = "";
	for (var i = 0; i < 16; i++) {
		celulas = celulas + '<button id="celula-' + linha + '-' + i + '" class="btn celula" onclick="toggle_celula(' + linha + ',' + i + ')"></button>';
	}

	return '<div id="linha-' + linha + '" class="linha">' + celulas + '</div>';
}

function get_efdd(linha,data) {
	var list ="";
	for (var i = 0; i < effect_json_data.length; i++) {
		if (valueInList(data,effect_json_data[i].name)) {
			list += '<li style="list-style-type:none"><input type="checkbox" onclick="sel_ef('+linha+',effect_json_data['+i+'].name)" checked><spam class="dditem-' + linha + '-' + i + ' dditem">' + effect_json_data[i].name + '</spam></li>'
		}
		else {
			list += '<li style="list-style-type:none"><input type="checkbox" onclick="sel_ef('+linha+',effect_json_data['+i+'].name)"><spam class="dditem-' + linha + '-' + i + ' dditem">' + effect_json_data[i].name + '</spam></li>'
		}
	}
	var ddown = '<div id="dd-btn-div-' + linha + '" class="dropright dd-btn">  <button id="dd-btn-' + linha + '" class="btn btn-primary dropdown-toggle dd-btn" type="button" id="dropdownMenuButton" data-toggle="dropdown">  <spam id="dd-text-' + linha + '">Efeito</spam>  </button>  <div id="ef1-ddown" class="dropdown-menu" aria-labelledby="dropdownMenuButton"><ul>' + list + '</ul></div>  </div>';
	return ddown;
}

function valueInList(list,val) {
	for (var count=0;count<list.length;count++) {
		if (val==list[count]) return true;
	}
	return false;
}
//********************
//********************



//********************
//SELECTING FUNCTIONS
//********************
function set_row_target(line) {
	row_sample_target = line;
}

function sel_samp(samp) {
	if (samp==undefined) {
		samparray[row_sample_target]="";
		document.getElementById("samp-btn-" + row_sample_target).innerHTML = "Excerto";
		matriz[row_sample_target] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		for (var col = 0; col < 16; col++) {
			reset_celula(row_sample_target, col);
		}
		efarray[row_sample_target] = [];
		if (efarray[row_sample_target].length==0) document.getElementById("dd-btn-"+row_sample_target).style.backgroundColor="#e9ecef";
		else document.getElementById("dd-btn-"+row_sample_target).style.backgroundColor="#e9ecef";
		document.getElementById("dd-btn-div-"+row_sample_target).innerHTML=document.getElementById("dd-btn-div-"+row_sample_target).innerHTML;
	}
	else {
		samparray[row_sample_target] = samp.id;
		var length = "";
		if (samp.name.length>9) {
			length = samp.name.substring(0,6) + "...";
		} else {
			length = samp.name;
		}
		document.getElementById("samp-btn-" + row_sample_target).innerHTML = length;
	}
	$('#sampmod').modal('hide');
}

//********************

function toggle_celula(line, col) {
	if (samparray[line]!="") {
		if (matriz[line][col] == 0) {
			document.getElementById("celula-" + line + "-" + col).style.backgroundColor = "#007bff";
			matriz[line][col] = 1;
		}
		else {
			document.getElementById("celula-" + line + "-" + col).style.backgroundColor = "white";
			matriz[line][col] = 0;
		}
	}
}

function reset_celula(line, col) {
	if (matriz[line][col] == 1) {
		document.getElementById("celula-" + line + "-" + col).style.backgroundColor = "#007bff";
		matriz[line][col] = 1;
	}
	else {
		document.getElementById("celula-" + line + "-" + col).style.backgroundColor = "white";
		matriz[line][col] = 0;
	}
}

//********************

function sel_ef(line, ef) {
	toggle_ef(line,ef);
	if (efarray[line].length==0) document.getElementById("dd-btn-"+line).style.backgroundColor="#e9ecef";
	else document.getElementById("dd-btn-"+line).style.backgroundColor="#007bff";
}

function toggle_ef(line, ef) {
	var found=false;
	var neweflist=[];
	for (var e=0;e<efarray[line].length;e++) {
		if (efarray[line][e]==ef) {
			found=true;
		}
		else if (efarray[line][e]!="") {
			neweflist[neweflist.length]=efarray[line][e];
		}
	}
	if (!found) neweflist[neweflist.length]=ef;
	efarray[line]=neweflist;
}
//********************
//********************


//********************
//SAVE MUSIC IN JSON
//********************
function save_json() {
	dic = {
		"name": "",
		"bpm": 0,
		"samples": [],
		"effects": [],
		"music": [[]]
	}
	dic.bpm = document.getElementById("input-bpm").value;
	
	dic.samples=samparray;
	
	dic.effects=efarray;
	
	var music=[];
	
	for (var i=0;i<matriz.length;i++) {
		for (var j=0;j<16;j++) {
			if (i==0) music[j]=[];
			if (matriz[i][j]==1) {
				music[j][music[j].length]=i;
			}
		}
	}
	dic.music=music;
	
	return dic;
}

function submit_pauta(){
	nome = document.getElementById("input-nome").value;
	pauta = save_json();

	pauta.name = nome;
	pauta = JSON.stringify(pauta);

	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", "put/", true);
	xhttp.setRequestHeader("Content-type", "application/json");
	xhttp.send(pauta);
}

//********************


function get_effects() {
	var effects_list_request = new XMLHttpRequest();
	effects_list_request.onreadystatechange = function () {
		if (effects_list_request.readyState == 4 && effects_list_request.status == 200) {
			effect_json_data = JSON.parse(effects_list_request.responseText);
			decide_init();
		}
	}
	effects_list_request.open("GET", "list/?type=effects", true);
	effects_list_request.send(null);
}

function get_audio() {
	var samp_list_request = new XMLHttpRequest();
	samp_list_request.onreadystatechange = function () {
		if (samp_list_request.readyState == 4 && samp_list_request.status == 200) {
			samp_json_data = JSON.parse(samp_list_request.responseText);
			fill_lists();
		}
	}
	samp_list_request.open("GET", "list/?type=samples&order=votos", true);
	samp_list_request.send(null);

	var song_list_request = new XMLHttpRequest();
	song_list_request.onreadystatechange = function () {
		if (song_list_request.readyState == 4 && song_list_request.status == 200) {
			song_json_data = JSON.parse(song_list_request.responseText);
			fill_lists();
		}
	}
	song_list_request.open("GET", "list/?type=songs&order=votos", true);
	song_list_request.send(null);
}

function fill_lists() {
	var filtro = document.getElementById("pesquisa").value;

	samp_list=`
		<div id="reset">
			<button onclick="sel_samp()">&#128465</button>
			<a style="margin-left: 10px;" onclick="sel_samp()">Nenhuma</a>
		</div>
	`;
	
	for (var i = 0; i < samp_json_data.length; i++) {
		var samp_data = samp_json_data[i];
		if (samp_data.name.includes(filtro)) {
			samp_list = samp_list + `
					<div class="sampleh inline">
						<button style="display: inline-block" id="control-` + samp_data.id + `" class="sampleh inline" onclick="control_player('` + samp_data.id + `')">&#9654</button>
						<div style="display: inline-block; width: 90%;" class="inline" onclick="sel_samp(samp_json_data[` + i + `])">
						<a style="margin-left: 10px;">` + samp_data.name + `</a>
						</div>
						<audio id="player-` + samp_data.id + `" src="/get/?id=` + samp_data.path + `" type="audio/mpeg"></audio>
					</div>
				`;
		}
	}
	document.getElementById("samp-list").innerHTML = samp_list;

	song_list=`
		<div id="reset" class="inline">
			<button style="display: inline-block" onclick="sel_samp()">&#128465</button>
			<a style="margin-left: 10px;" onclick="sel_samp()">Nenhuma</a>
		</div>
	`;
	
	for (var i = 0; i < song_json_data.length; i++) {
		var song_data = song_json_data[i];
		if (song_data.name.includes(filtro)) {
			song_list = song_list + `
					<div class="sampleh">
						<button id="control-` + song_data.id + `" class="sampleh" onclick="control_player('` + song_data.id + `')">&#9654</button>
						<a style="margin-left: 10px;"  onclick="sel_samp(song_json_data[` + i + `])">` + song_data.name + `</a>
						<audio id="player-` + song_data.id + `" src="/get/?id=` + song_data.path + `" type="audio/mpeg"></audio>
					</div>
				`;
		}
	}
	document.getElementById("song-list").innerHTML = song_list;
}

function control_player(id) {
	var player = document.getElementById("player-" + id);
	var control = document.getElementById("control-" + id);

	player.addEventListener("ended", function () {
		control.innerHTML = "&#9654";
	});

	if (!player.paused) {
		player.pause();
		control.innerHTML = "&#9654";
	}

	else {
		player.play();
		control.innerHTML = "&#9208";
	}
}

function decide_init() {
	var url = new URL(window.location.href);
	var id = url.searchParams.get("id");

	get_audio();

	if (id == undefined) {
		init_grid();
	}
	else {
		var songgen_request = new XMLHttpRequest();
		songgen_request.onreadystatechange = function () {
			if (songgen_request.readyState == 4 && songgen_request.status == 200) {
				json_data = JSON.parse(songgen_request.responseText);

				init_json(json_data);
			}
		}
		songgen_request.open("GET", "songgen/?id=" + id, true); // true for asynchronous 
		songgen_request.send(null);
	}
}

get_effects(); // buscar effects, só depois decidir init
