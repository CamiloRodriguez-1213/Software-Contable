$( document ).ready(function() {
    var total = document.getElementById("total")
    var valor = document.getElementsByName("valor")
    var subtotal = document.getElementsByName("subtotal")
    var cantidad = document.getElementsByName("cantidad")
    for (let h = 0; h < valor.length; h++) {
        var tot = parseInt(valor[h].value*cantidad[h].value)
        subtotal[h].value = tot
    }
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