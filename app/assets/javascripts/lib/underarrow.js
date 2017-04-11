$(document).on('turbolinks:load', function() {
  $('.debts-displayed-on-bet').ready(function() {
    const debtAmounts = $('.debt-amount');
    const debtAmountWidths = $.map(debtAmounts, function(element) {
      return $(element).width();
    });

    const underarrows = $('.underarrow');
    const underarrowWidths = $.map(underarrows, function(element) {
      return $(element).width();
    });

    $.each(underarrows, function(index, underarrow) {
      const debtAmountWidth = debtAmountWidths[index];
      const underarrowWidth = underarrowWidths[index];
      const scaleAmount = (debtAmountWidth / underarrowWidth).toFixed(2);
      $(underarrow).css({'transform': 'scale(' + scaleAmount + ', 0.8)'});
      $(underarrow).css({'transform-origin': 'left top'});
    });
  });
});
