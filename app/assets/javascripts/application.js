//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require cocoon
//= require confirm
//= require chartkick
//= require bootstrap-table
//= require_tree .


$(function () {
  $('[data-toggle="tooltip"]').tooltip();
  $('[type="checkbox"]').bootstrapSwitch();
  // Make sure checkbox switch works
  $(".add_fields").click( function () {
    $("[type='checkbox']").bootstrapSwitch();
  });
  // FIX Adds form-control to date_select
  $("select").addClass("date-control");

  // Display current image selected (input file)
  //$("#target_parent").hide();
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      //console.log(file);
      img.src = file.target.result;
      $('#target').html(img);
      //$("#target_parent").show();
    }
    reader.readAsDataURL(image);
    //console.log(files);
  });
  //Conver tr into link_to
  $("tr[data-link]").click(function() {
    window.location = $(this).data("link");
  });

});


  //Adds bootstrapSwitch to current partial
  $("[type='checkbox']").bootstrapSwitch();
  $(".shipment-fields select, .shipment-fields input[type='number']").css("width","100%");



       /*$('.prod').on('change', function(params){
          //27 es el tamaño del base_string, es fijo, no cambia.
          //40 es cuando termina el ID dinámico del producto del que queremos
          // filtrar sus count_types
          //var base_string = 'sale[shipments_attributes][';
          //var end_string = '][product_id]';
          var shipment_auto_rails_id = params.target.name.substring(27,40);
          //alert(product_rails_id);
          //alert(params.target.name);

          product_id_val = $(this).val();
          var product_select = $(this);

              var params = {
            product_id: product_id_val
          };
          $.ajax({
            url: '<%= get_product_count_types_path %>',
            type: 'GET',
            data: $.param(params),
            dataType: 'json',
            success: function (dataRes) {
              var types_select = $("select[name$='["+shipment_auto_rails_id+"][count_type_id]']")
              clearTarget(types_select);

              //Se recibe el arreglo de objetos, hay que acomodarlos en el select
            var types = $.parseJSON(dataRes);
            filter_count_types(types_select, types);

            }
          });


          function clearTarget(count_types_select){
               count_types_select.children().remove().end()
               .append('<option selected value>N/A</option>');
          }


          function filter_count_types(count_types_select, types){
                $.each(types, function(key, value) {
              count_types_select
             .append($("<option></option>")
             .attr("value" , value[0])
             .text(value[1]));
              });
          }


       });
*/
