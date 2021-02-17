// Rodrigo Rosmaninho e Jorge C. Silva - UA 2018

var s;

function mostrarMapa() {
    prepararHTML();

    var map = new L.Map("DetiMapa", { center: [40.633186737230076, -8.659393787384035], zoom: 17 });
    var osmUrl = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
    var osmAttrib = "Map data OpenStreetMap contributors";
    var osm = new L.TileLayer(osmUrl, { attribution: osmAttrib });
    map.addLayer(osm);
    map.on("click", mostraCoordenadas);

    s = document.getElementById("coordenadas");
    s.innerHTML = "Latitude, Longitude = 40.633186737230076, -8.659393787384035";

    var pontos = [
        L.marker([40.633186737230076, -8.659393787384035]).bindPopup("DETI - UA")
    ];

    for (i in pontos) {
        pontos[i].addTo(map);
    }
}

function mostraCoordenadas(e){
    s.innerHTML = "Latitude, Longitude = "+e.latlng.lat+", "+e.latlng.lng;
}

function prepararHTML(){
    document.getElementById("mapa").innerHTML="<div id='DetiMapa' style='width: 600px; height: 500px'></div><span id='coordenadas'></span>";
}