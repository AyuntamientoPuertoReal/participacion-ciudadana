$(document).on("turbolinks:load", function () {
    var function_search = function() {
        $.get($("#processing_units_search").attr("action"), $("#processing_units_search").serializeArray(), null, "script");
        return false;
    };

    $("#search_code").keyup(function_search);

    $("#search_description").keyup(function_search);
});