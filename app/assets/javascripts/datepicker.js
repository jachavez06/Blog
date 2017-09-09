$(document).on('turbolinks:load', function() {
    $('.date').datepicker({
        todayHighlight: true,
        autoclose: true,
        format: "yyyy-mm-dd"
    });
});
