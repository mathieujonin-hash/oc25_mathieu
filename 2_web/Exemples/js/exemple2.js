console.log("Ready");

const statut = document.getElementById("statut");
const ctx_statut = statut.getContext("2d");

ctx_statut.fillStyle = "green";
ctx_statut.fillRect(0, 0, 300, 300);

const dessin = document.getElementById("dessin");
const context = dessin.getContext("2d");

c = context;

c.strokeStyle = "rgba(38, 155, 157, 1)";
c.fillStyle = c.strokeStyle;

c.beginPath();
c.moveTo(250, 100);
c.lineTo(10, 250);
c.lineTo(250, 400);
c.lineTo(150, 250);
c.closePath();
c.fill();
c.stroke();

c.strokeStyle = "black";

c.beginPath();
c.arc(270, 250, 100, 0, 2 * Math.PI);
c.stroke();
c.fill();


// context.fillStyle = "black";
// var pix = 50;
// for (var i = 0; i < pix; i++) {
//     for (var j = 0; j < pix; j++) {
//         if ((i + j) % 2 == 0) { context.fillStyle = "black"; } else { context.fillStyle = "white"; }
//         context.fillRect(i * pix, j * pix, pix, pix);
//     }
// }