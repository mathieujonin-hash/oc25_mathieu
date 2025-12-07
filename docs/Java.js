function toggleMenu() {
    document.getElementById("sideMenu").classList.toggle("open");
}

//animation

const image = document.getElementById("image");
const ctx_image = image.getContext("2d");

const img = new Image();
img.src = "/docs/cat-space.gif"

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
    ctx_image.clearRect( -100, -100, 800, 800 );
    ctx_image.drawImage( img, 0, 0, w, h );
    ctx_image.translate( k, l );
    if ( k == 1 ) {
        if (i < 800-w) { k = 1; }
        else { k = -1; i = 0; }
    } else {
        if (i < 800-w) { k = -1; }
        else { k = 1; i = 0; }
    }
    if ( l == 1 ) {
        if (j < 450-h) { l = 1; }
        else { l = -1; j = 0; }
    } else {
        if (j < 450-h) { l = -1; }
        else { l = 1; j = 0; }
    }
    i++
    j++
    window.requestAnimationFrame(draw);
}

init()