$(document).ready(function() {
    var datosTabla = $('#table_product')
    $.ajax({
        url: '/tabla',
        type: 'GET',
        success: function(response){
            datosTabla.DataTable({
                pageLenght:10,
                "data":response['datos'][0],
                "columns":[
                    { "data": "codigo" },
                    { "data": "nombre" },
                    { "data": "existencia" },
                    { "data": "categoria" },
                    { "data": "precio" },
                ]
            })
        }
    })
    
});