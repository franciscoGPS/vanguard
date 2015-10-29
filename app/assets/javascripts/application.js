//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
//= require cocoon
//= require confirm

$(function () {
  $('[data-toggle="tooltip"]').tooltip();
  $('[type="checkbox"]').bootstrapSwitch();
  // Make sure checkbox switch works
  $(".add_fields").click( function () {
    $("[type='checkbox']").bootstrapSwitch();
  });
  // FIX Adds form-control to date_select
  $("select").addClass("date-control");
});
