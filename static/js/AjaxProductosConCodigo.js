//document.getElementById('existencia').disabled = 'true'
$(document).ready(function(){
    function ajax_product(){
        codigo = document.getElementById('codigo').value
        
        id = document.getElementById('id')
        cod_product = document.getElementById('cod_product')
        nombre = document.getElementById('nombre')
        input = document.getElementById('input_categoria')
        precio_venta = document.getElementById('precio_venta')
        existencia = document.getElementById('existencia')

        myModal = document.getElementById('staticBackdrop')
        $.ajax({
            url: '/producto-codigo',
            data: $('form').serialize(),
            type: 'POST',
            success: function(response){
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
                    }), 

                    document.getElementById('mensaje_modal').innerHTML = 'El producto de codigo "'+codigo+'" no existe, verifique que el codigo sea correcto o ingrese los datos del producto para crearlo'
                    myModal.addEventListener('show.bs.modal', () => {
                        myInput.focus()
                    })
                }
            },
            error: function(error){
                console.log(error);
            }
        });
    }

    $('#get_product').submit(function(e){
        e.preventDefault();
        ajax_product();
    })
});
