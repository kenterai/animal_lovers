$(document).on('turbolinks:load', function () {
  const back = $('#back');

  back.hide();

  $(window).on('scroll',function () {
    if ($(this).scrollTop() > 100) {
      back.fadeIn();
    } else {
      back.fadeOut();
    }
  });

  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});