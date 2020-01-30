$(document).on("turbolinks:load", function () {
    var function_search = function() {
        $.get($("#news_search").attr("action"), $("#news_search").serializeArray(), null, "script");
        return false;
    };

    $("#search_title").keyup(function_search);

    $("#search_author").keyup(function_search);

    $("#search_createdAt").keyup(function_search);

    $("#search_published").change(function_search);
});