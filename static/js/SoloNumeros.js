jQuery(document).ready(function(){
	jQuery("#codigo").on('input', function (evt) {
		jQuery(this).val(jQuery(this).val().replace(/[^0-9]/g, ''));
	});
	jQuery("#cod_product").on('input', function (evt) {
		jQuery(this).val(jQuery(this).val().replace(/[^0-9]/g, ''));
	});
});