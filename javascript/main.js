$(document).ready(function(){

    $('.hidden > .hidden-content').hide();
    $('.hidden').click(function(e) {
        if(getSelection().toString()){ return; }
        $(this).find('> .hidden-content').toggle();
        e.stopPropagation();
    });

    $('a').each(function(index){
        var anchor = $(this).attr('href');
        if (/^[^:]*\.md$/.test(anchor)) { $(this).attr({ href: anchor.substring(0, anchor.length-3)+".html" }); }
        if (/^[^:]*\.org$/.test(anchor)) { $(this).attr({ href: anchor.substring(0, anchor.length-4)+".html" }); }
    });

    if (/(.html|\/)$/.test(window.location.href)) {
        $('#ui-id-2').click();
        setTimeout(function() { $(window).scrollTop(0); }, 100);
    }

});
