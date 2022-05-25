$( document ).ready(function() {
    document.getElementById("search").focus(function () {
        location.reload();
        
    })
    cantTotal();
    search();
    envFormulario();
});
    function envFormulario(){
        $('#formFactura').submit(function (ev) {
            $.ajax({
            type: 'POST', 
            url: '/newBuy',
            data: $(this).serialize(),
            dataType : 'json',
            success: function (data) { 
                console.log(data)
            } 
            });
            ev.preventDefault();
          });
    }
    function search() {
        $('#form_search').submit(function (ev) {
            
            $.ajax({
            type: 'POST', 
            url: '/',
            data: $(this).serialize(),
            dataType : 'json',
            success: function (data) { 
                console.log(data)
            } 
            });
            
          });
    }
    function cantTotal(){
        var total = document.getElementsByName("total")    
        var valor = document.getElementsByName("valor")
        var subtotal = document.getElementsByName("subtotal")
        var cantidad = document.getElementsByName("cantidad")
        var totalacum = 0
        for (let h = 0; h < valor.length; h++) {
            var tot = parseInt(valor[h].value*cantidad[h].value)
            subtotal[h].value = tot
            totalacum = parseInt(totalacum +tot)
            tot = parseInt(valor[h].value*cantidad[h].value);
            subtotal[h].value = tot;
        }
        total[0].value = totalacum;
    }