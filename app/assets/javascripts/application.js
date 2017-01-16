//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require cocoon
//= require confirm
//= require chartkick
//= require bootstrap-table
//= require filterrific/filterrific-jquery
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require sales_state_machine
//= require jquery-readyselector
//= require_tree .



$(document).ready(function () {

  $('[data-toggle="tooltip"]').tooltip();
  $('[type="checkbox"]').bootstrapSwitch('size', "mini");
  // Make sure checkbox switch works
  $(".add_fields").click( function () {
    $("[type='checkbox']").bootstrapSwitch('size', "mini");
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


    //Adds bootstrapSwitch to current partial

  $(".shipment-fields select, .shipment-fields input[type='number']").css("width","100%");


  function check_max_length(text_area_object)
  {
        var iMaxLen = parseInt(text_area_object.getAttribute('maxlength'));
        var iCurLen = text_area_object.value.length;

        if ( text_area_object.getAttribute && iCurLen > iMaxLen )
        {
            text_area_object.value = text_area_object.value.substring(0, iMaxLen);
        }
  }


});

function show_error(param){
  if (param == "server_error"){
    alert("Server problem, try reload your browser.");
  }
}


/***************************************************************************************
//Starts state machine code.

$('input[name=selected]:radio')
              .on('change', function () {

          //Establece el valor en el campo oculto dependiendo de la venta que que se vaya a actualizar
          $('#sale_id_hidden').val($(this).val());
          //Establece el valor de la venta en la parte d elos controles.
          //Se puede poblar cualquier campo a partir de este id
          $('#sale_id_status').html("Shipment - " + $(this).val());

          enviar_ajax("", false);

        });

        $('#save_qty').on("click", function(){
          var qty = $("#hld_qty").val();
          enviar_ajax("hld_qty", qty);

        });



      //###########   Los 12 eventos de los checkboxes y sus respectivas lógicas...
      //Ordenados de manera desendente
      //
      //=============================================================================

      //Evento accionado
      $('#purshase_order_state_check')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0)
            enviar_ajax(this.name, state);
        });

      //Segunda 2
      $('#out_of_packaging')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Tercera 3
      $('#docs_reception')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Cuarta 4
      $('#loading_docs')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Quinta 5
      $('#arrived_to_border')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Sexta 6
      $('#out_of_courtyard')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Séptima 7
      $('#documents')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Octava 8
      $('#mex_customs_mod')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Novena 9
      $('#us_customs_mod')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Décima 10
      $('#arrived_to_warehouse')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Undécima 11
      $('#picked_up_by_cust')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Duodécima 12
      $('#bol')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

        //revision 13
      $('#revision')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE

            enviar_ajax(this.name, state);
          }
        });

      //usda 14
      $('#usda')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //fda 15
      $('#fda')
        .on('switchChange.bootstrapSwitch', function (event, state) {
          if ($('#sale_id_hidden').val() > 0) {
            //Se verifica el estado del switch para saber si activar o desactivar
            //los campos de qty on hold
          if (state == false){
            $('#save_qty').prop('disabled', true);
            $('#hld_qty').prop('disabled', true);
            $('#save_qty').removeClass("btn-warning");
          }else{
            $('#save_qty').prop('disabled', false);
            $('#hld_qty').prop('disabled', false);
            $('#save_qty').addClass("btn-warning");
          }
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });

      //Rampa 16
      $('#ramp')
        .on('switchChange.bootstrapSwitch', function (event, state) {

          if ($('#sale_id_hidden').val() > 0) {
            //Se envían los valores para los parámetros del ajax
            //Los valores son:
            //-El nombre del campo (Que es el correspondiente al estado solicitado o clickado)
            //-El valor de si fue clickado hacia TRUE o FALSE
            enviar_ajax(this.name, state);
          }
        });




      //
      //=============================================================================

      function enviar_ajax(accion_param, checked) {

          var params = {
            accion: accion_param,
            //Cuando la función es llamada desde el botón para guardar la cantidad,
            //el valor de checked es un número y la acción es save_qty
            valor: checked,
            sale_id: $('#sale_id_hidden').val()
          };


            $.ajax({
            url: '<%= purshase_order_state_change_path %>',
            type: 'GET',

            data: $.param(params),
            dataType: 'json',
            success: function (dataRes) {

              //Recibir el objeto venta(Sale) y acomodar sus booleanos de los estados
              //updated_sale es el objeto tipo venta. Se convierte a objeto y se puede acceder a sus propiedades con el operador .  ej.a lert(updated_sale.aasm_state);
              //var updated_sale = $.parseJSON(dataRes);

              var updated_sale =  dataRes["sale"];

              console.log(updated_sale);


              if(updated_sale == null){
              }
              else{
                seleccionar_campos(updated_sale);
                var action = dataRes["action"];
                var status = dataRes["status"];
                if(status){
                  if(action == "hld_qty"){
                    disable_saving_fields();
                  }
                }
              }
            }
          });
      }

      function disable_saving_fields(){
                $('#save_qty').removeClass("btn-warning");
                $('#hld_qty').prop('disabled', true);
                $('#save_qty').prop('disabled', true);
                enviar_ajax("", false);

      }

      function initialize(){
            $('#save_qty').prop('disabled', true);
            $('#hld_qty').prop('disabled', true);
            $('#sale_id_status').html("Shipment - " + $(this).val());
            enviar_ajax("", false);
        }

      function seleccionar_campos(sale) {
        /*
        Special Behaviours
          The method state can receive an optional third parameter skip. if true,
          switchChange event is not executed. The default is false.
          The method toggleState can receive an optional second parameter skip.
           if true, switchChange event is not executed. The default is false.
          The method wrapperClass can accepts a falsy value as second parameter.
           If so, it resets the class to its default.
         */
        /*

        $('#purshase_order_state_check').bootstrapSwitch('state', sale.purshase_order, true);
        //Segunda 2
        $('#out_of_packaging').bootstrapSwitch('state', sale.out_of_packaging, true);
        //Tercera 3
        $('#docs_reception').bootstrapSwitch('state', sale.docs_reception, true);
        //Cuarta 4
        $('#loading_docs').bootstrapSwitch('state', sale.loading_docs, true);
        //Quinta 5
        $('#arrived_to_border').bootstrapSwitch('state', sale.arrived_to_border, true);
        //Sexta 6
        $('#out_of_courtyard').bootstrapSwitch('state', sale.out_of_courtyard, true);
        //Séptima 7
        $('#documents').bootstrapSwitch('state', sale.documents, true);
        //Octava 8
        $('#mex_customs_mod').bootstrapSwitch('state', sale.mex_customs_mod, true);
        //Novena 9
        $('#us_customs_mod').bootstrapSwitch('state', sale.us_customs_mod, true);
        //Décima 10
        $('#arrived_to_warehouse').bootstrapSwitch('state', sale.arrived_to_warehouse, true);
        //Undécima 11
        $('#picked_up_by_cust').bootstrapSwitch('state', sale.picked_up_by_cust, true);
        //Duodécima 12
        $('#bol').bootstrapSwitch('state', sale.bol, true);
        //Revisión 13
        $('#revision').bootstrapSwitch('state', sale.revision, true);
        // usda 14
        $('#usda').bootstrapSwitch('state', sale.usda, true);
        //fda 15
        $('#fda').bootstrapSwitch('state', sale.fda, true);
        //rampa 16
        $('#ramp').bootstrapSwitch('state', sale.ramp, true);

        //cantidad retenida en FDA 18
        $('#hld_qty').val(sale.hld_qty);

      }

      //Ends state machine code
/*******************************************************************************************/







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
