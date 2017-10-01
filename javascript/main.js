$('.hidden .hidden-content').hide();
$('.hidden > strong').click(function() {
      $(this).parent().find('.hidden-content').toggle();
});
