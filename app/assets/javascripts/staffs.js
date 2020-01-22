$(document).on("turbolinks:load", function () {
    var function_search = function() {
        $.get($("#staffs_search").attr("action"), $("#staffs_search").serializeArray(), null, "script");
        return false;
    };

    $("#search_code").keyup(function_search);

    $("#search_name").keyup(function_search);

    $("#search_ut").keyup(function_search);
});