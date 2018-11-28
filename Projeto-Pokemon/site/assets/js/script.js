var indice = 0;
var CAMINHO = [];
var mapa;

function proximo() {
	if(indice < CAMINHO.length - 1) {
		indice++; 
	}
	carregaMapa();
}

function anterior() {
	if(indice > 0) {
		indice--;
	}
	carregaMapa();
}

function imagem(item) {
	return "<img src='assets/img/" + item + ".png'/>";
}

function carregaMapa() {
	var table;
	table = "<table   id='pagads'>";
	CAMINHO[indice].forEach(function(andar) {
		table += "<tr id='pagads-tr'>";
		andar.forEach(function(item) {
			table += "<td id='pagads-td'>" + imagem(item) + "</td>";
		});
		table += "</tr>";
	});
	table += "</table>";
	mapa.innerHTML = table;

	document.getElementById("passos").innerHTML = "Passo " + (indice+1) + " de " + CAMINHO.length + ".";
}

function gerarMapa() {

	indice = 0;
	CAMINHO = [];
	mapa = document.getElementById("mapa");

	var input = document.getElementById("input").value;
	input = input.replace(/pokemon3/g, 5);
	input = input.replace(/pokebola/g, 6);
	input = input.replace(/ash/g, 0);
	input = input.replace(/cam/g, 1);
	input = input.replace(/obj/g, 2);
	input = input.replace(/pokemon2/g, 3);
	input = input.replace(/pokemon1/g, 4);
	var lido = parse(input);
	lido = lido[0];

	for(var i = lido.length -1; i >= 0 ; i--) {
		var andar = [];
		for(var j = lido[i].length -1; j >= 0; j--) {
			andar.push(lido[i][j]);
		}
		CAMINHO.push(andar);
	}

	carregaMapa();
}


function parse(str) {
	return (new Function("return [" + str+ "];")());
}
