$( document ).ready(function() {
    var total = document.getElementById("total")
    var subtotal = document.getElementsByTagName("cantidad")
    console.log(subtotal)
    total.value = leerCookie('subtotal');
});
function leerCookie(nombre) {
    var lista = document.cookie.split(";");
    for (i in lista) {
        var busca = lista[i].search(nombre);
        if (busca > -1) {micookie=lista[i]}
        }
    var igual = micookie.indexOf("=");
    var valor = micookie.substring(igual+1);
    return valor;
    }