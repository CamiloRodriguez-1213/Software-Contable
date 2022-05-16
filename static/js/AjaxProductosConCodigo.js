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
                    console.log(document.cookie)
                    input.innerHTML = '<select id="categoria" name="categoria" class="form-select">'+
                                            '<option >Seleccione una categoria</option>'+
                                            '{% for db_categoria in db_categorias %}'+
                                                '{% if db_categoria[0] == categoria %}'+
                                                    '<option value="{{ db_categoria[0] }}" selected>{{ db_categoria[1] }}</option>'+
                                                '{% else %}'+
                                                    '<option value="{{ db_categoria[0] }}" >{{ db_categoria[1] }}</option>'+
                                                '{% endif %}'+
                                            '{% endfor %}'+
                                        '</select>'
                    //input.innerHTML = "<input type='text' class='form-control' id='categoria' name'categoria' value="+response[7]+" disabled>";
                    precio_venta.value = response[3]
                    existencia.value = response[5]
                }else{
                    id.value = ''
                    cod_product.value = ''
                    nombre.value = ''
                    precio_venta.value = ''
                    existencia.value = ''
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
