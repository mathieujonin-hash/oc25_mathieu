console.log("Ready");

const statut = document.getElementById("statut");
const ctx_statut = statut.getContext("2d");

ctx_statut.fillStyle = "green";
ctx_statut.fillRect(0, 0, 300, 300);

const dessin = document.getElementById("dessin");
const context_dessin = dessin.getContext("2d");

c = context_dessin;

c.strokeStyle = "black";
c.fillStyle = "rgba(38, 155, 157, 1)";

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
c.arc(271, 250, 100, 0, 2 * Math.PI);
c.fill();
c.stroke();


const image = document.getElementById("image");
const ctx_image = image.getContext("2d");

const img = new Image();
img.src = "/docs/dvd-logo-svgrepo-com.svg"

function init() {
    window.requestAnimationFrame(draw);
}

var w = img.naturalWidth/4;
var h = img.naturalHeight/4;

 var i = 0;
 var j = 0;
 var k = 1;
 var l = 1;

function draw() {
    ctx_image.clearRect( -10, -10, 600, 600 );
    ctx_image.drawImage( img, 0, -40, w, h );
    ctx_image.translate( k, l );
    if ( k == 1 ) {
        if (i < 500-w) { k = 1; }
        else { k = -1; i = 0; }
    } else {
        if (i < 500-w) { k = -1; }
        else { k = 1; i = 0; }
    }
    if ( l == 1 ) {
        if (j < 580-h) { l = 1; }
        else { l = -1; j = 0; }
    } else {
        if (j < 580-h) { l = -1; }
        else { l = 1; j = 0; }
    }
    i++
    j++
    window.requestAnimationFrame(draw);
}

init()