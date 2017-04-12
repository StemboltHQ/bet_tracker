$(document).on('turbolinks:load', function() {
  $('.jquery-datepicker').datetimepicker( {
    minDate: '0',
    format: 'Y-m-d G:i:s P',
  });
});
