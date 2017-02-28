$(document).on('turbolinks:load', function () {
    $("#selectImage").imagepicker({
        hide_select: true,
        show_label  : true
    });

    var $container = $('.image_picker_selector');
    // initialize
    $container.imagesLoaded(function () {
        $container.masonry({
            columnWidth: 10,
            itemSelector: '.thumbnail'
        });
    });
});

$(document).on('turbolinks:load', function () {
    var owl = $('.owl-carousel');
    owl.owlCarousel({
        items:5,
        loop:true,
        margin:10,
        autoplay:true,
        autoplayTimeout:4000,
        autoplayHoverPause:false
    });
    $('.play').on('click',function(){
        owl.trigger('play.owl.autoplay',[1000])
    })
    $('.stop').on('click',function(){
        owl.trigger('stop.owl.autoplay')
    })
});

$(document).on('turbolinks:load', function () {
  var games = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/games/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#query').typeahead({
    hint: true,
    minLength: 1,
    limit: 10,
  },
  {
    source: games
  });
});
