$(document).on("turbolinks:load", function () {
    var function_search = function() {
        $.get($("#news_search").attr("action"), $("#news_search").serializeArray(), null, "script");
        return false;
    };

    $("#search_title").keyup(function_search);

    $("#search_author").keyup(function_search);

    $("#search_createdAt").change(function_search);

    $("#search_published").change(function_search);

    $('.datepicker').fdatepicker({
        closeButton: true,
        language: 'es',
        format: 'dd/mm/yyyy',
    });
});