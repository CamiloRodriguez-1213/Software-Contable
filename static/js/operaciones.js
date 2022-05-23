$( document ).ready(function() {
    var id = document.getElementsByName("id")
    var codigo = document.getElementsByName("codigo")
    var nombre = document.getElementsByName("nombre")
    var existencia = document.getElementsByName("existencia")
    var valor = document.getElementsByName("valor")
    var cantidad = document.getElementsByName("cantidad")
    var subtotal = document.getElementsByName("subtotal")
    var total = document.getElementsByName("total")
    total.value = leerCookie('subtotal');
    $('#cantidad').change(function(){
        var cantidad = document.getElementsByName("cantidad")
        console.log(cantidad.value)
    });
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