document.addEventListener("turbolinks:load", function() {
    var data = $('body').data();
    if (data.controller === 'articles' && data.action === 'show'){
        $('pre code').each(function(i, e) {hljs.highlightBlock(e)});
    };
});