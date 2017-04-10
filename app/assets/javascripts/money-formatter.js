$(document).on('turbolinks:load', function() {
  $('.money-formatter').on('keyup', function() {
    let amount = $(this).val();
    let dollarsAndCents = amount.split('.').slice(0, 2);
    let dollars = dollarsAndCents[0];
    let cents = dollarsAndCents.length > 1 ? dollarsAndCents[1] : '0';
    console.log(cents.length);
    if(cents.length > 2) {
      let truncatedAmount = dollars + '.' + cents.slice(0, 2);
      $(this).val(truncatedAmount);
    }
  });
});
