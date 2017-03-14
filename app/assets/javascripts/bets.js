$(document).on('turbolinks:load', function() {
  $(".table-selectable tr").on('click', function(event){
    $("tr").removeClass("table-success");
    if (event.target.type !== "radio"){
      $(":radio", this).trigger('click')
    }
    $(this).addClass("table-success");
  });
});
