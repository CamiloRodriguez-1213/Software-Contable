//document.getElementById('existencia').disabled = 'true'
$(document).ready(function(){
    $('#form_get_product').submit(function(e){
        e.preventDefault();
        ajax_product();
    })
    
    function ajax_product(){
        codigo = document.getElementById('codigo').value
        
        id = document.getElementById('id')
        cod_product = document.getElementById('cod_product')
        nombre = document.getElementById('nombre')
        input = document.getElementById('input_categoria')
        precio_venta = document.getElementById('precio_venta')
        existencia = document.getElementById('existencia')

        search_alert = document.getElementById('search_alert')

        $.ajax({
            url: '/producto-codigo',
            data: $('form').serialize(),
            type: 'POST',
            success: function(response){
                console.log(response)
                if(response != null){
                    id.value = response[0]
                    cod_product.value = response[1]
                    nombre.value = response[2]
                    $.ajax({
                        url: '/categorias',
                        type: 'GET',
                        success: function(db_categorias){
                            input.innerHTML = '<select id="categoria" name="categoria" class="form-select"><option>Seleccione una categoria</option></select>'
                            $.each(db_categorias,function(key, registro) {
                                if(registro[0] == response[7])
                                {
                                    $("#categoria").append('<option value='+registro[0]+' selected>'+registro[1]+'</option>');
                                }else{
                                    $("#categoria").append('<option value='+registro[0]+'>'+registro[1]+'</option>');
                                }
                            });   
                        },error: function(error){console.log(error);}
                    })
                    precio_venta.value = response[3]
                    existencia.value = response[5]

                }else{
                    search_alert.innerHTML = '<div class="alert alert-danger alert-dismissible fade show" role="alert">'+
                                                'El producto de codigo <strong>'+codigo+'</strong> no existe, ingrese los datos del producto y proveedor para registrarlo.'+
                                                '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>'+
                                            '</div>'

                    id.value = ''
                    cod_product.value = ''
                    nombre.value = ''
                    precio_venta.value = ''
                    existencia.value = ''
                    $.ajax({
                        url: '/categorias',
                        type: 'GET',
                        success: function(db_categorias){
                            input.innerHTML = '<select id="categoria" name="categoria" class="form-select"><option>Seleccione una categoria</option></select>'
                            $.each(db_categorias,function(key, registro) {
                                $("#categoria").append('<option value='+registro[0]+'>'+registro[1]+'</option>');
                            });      
                        },error: function(error){console.log(error);}
                    })
                }
            },
            error: function(error){
                console.log(error);
            }
        });
    }
});
