const statut = document.getElementById("statut");
const ctx_statut = statut.getContext("2d");

ctx_statut.fillStyle = "green";
ctx_statut.fillRect(0, 0, 300, 300);

const dessin = document.getElementById("dessin");
const context = dessin.getContext("2d");

context.fillStyle = "black";
var pix = 50;
for (var i = 0; i < pix; i++) {
    for (var j = 0; j < pix; j++) {
        if ((i + j) % 2 == 0) { context.fillStyle = "black"; } else { context.fillStyle = "white"; }
        context.fillRect(i * pix, j * pix, pix, pix);
    }
}