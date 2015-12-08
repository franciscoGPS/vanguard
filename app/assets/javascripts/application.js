//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require cocoon
//= require confirm
//= require_tree .
//= require chartkick

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
