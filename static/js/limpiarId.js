document.getElementById('codigo').addEventListener('input', function(){
    id = document.getElementById('id')
    cod_product = document.getElementById('cod_product')
    nombre = document.getElementById('nombre')
    input = document.getElementById('input_categoria')
    precio_venta = document.getElementById('precio_venta')
    existencia = document.getElementById('existencia')

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
})

document.getElementById('cod_product').addEventListener('input', function(){
    id = document.getElementById('id')
    codigo = document.getElementById('codigo')
    nombre = document.getElementById('nombre')
    input = document.getElementById('input_categoria')
    precio_venta = document.getElementById('precio_venta')
    existencia = document.getElementById('existencia')

    id.value = ''
    codigo.value = ''
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
})