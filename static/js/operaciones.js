$( document ).ready(function() {
    document.getElementById("search").focus(function () {
        location.reload();
    })
    document.getElementById('id_user').addEventListener('keydown', inputCharacters);
    cantTotal();
    search();
    envFormulario();
});
    function inputCharacters(event) {
        if (event.keyCode == 13) {
            id_user = document.getElementById('id_user')
            id_us = document.getElementById('id_us')
            nombre_user  = document.getElementById('nombre_user')
            cel_user = document.getElementById('cel_user')
            email_user = document.getElementById('email_user')
            console.log(id_user.value)
            $.ajax({
                type: 'POST', 
                url: '/userQuery',
                data: {"value":id_user.value},
                dataType : 'json',
                success: function (data) { 
                    id_us.value = data[0]
                    nombre_user.value = data[2]+' '+data[3]
                    cel_user.value = data[4]
                    email_user.value = data [5]
                } 
            });
        }
    }
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