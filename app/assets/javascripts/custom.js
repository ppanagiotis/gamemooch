$(document).ready(function () {
    $("#selectImage").imagepicker({
        hide_select: true,
        show_label  : true
    });

    var $container = $('.image_picker_selector');
    // initialize
    $container.imagesLoaded(function () {
        $container.masonry({
            columnWidth: 30,
            itemSelector: '.thumbnail'
        });
    });
});
