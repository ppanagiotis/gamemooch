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
