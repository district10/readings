$(document).ready(function(){

    $('table').wrap('<div class="table-container"></div>');

    $('.tzx-folder > .tzx-foldable').hide();
    $('.tzx-folder').click(function(e) {
        if(getSelection().toString()){ return; }
        $(this).find('> .tzx-foldable').toggle();
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

    $('#postamble > p.author').click((function() {
        toggleHideShow = (function() {
            var isHiding = true;
            var $hidable = $('.tzx-hide');
            function hide() { $hidable.removeClass('tzx-show').addClass('tzx-hide'); }
            function show() { $hidable.removeClass('tzx-hide').addClass('tzx-show'); }
            return function() {
                isHiding? show(): hide();
                isHiding = !isHiding;
            };
        })();
        return function() { if(getSelection().toString() === 'TANG'){ toggleHideShow(); } };
    })());

    $('div.org-src-container pre.src').each(function(i, block) {
        hljs.highlightBlock(block);
    });


    $('.coderef-off').each(function(){
        var $this = $(this);
        if ($this.attr('id').startsWith("coderef-h")) {
            $this.addClass("highlighted");
        }
    });

    var srcUrl = "https://raw.githubusercontent.com/district10/readings/gh-pages"+window.location.href.split("/readings")[1].split(".")[0]+".org"
    $('#postamble').append( "<a class='source' href='"+srcUrl+"'>笔记源码</a>" ).find("p.validation").remove();
});
