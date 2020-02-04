$(document).on("turbolinks:load", function () {
    var function_search = function() {
        $.get($("#incidences_search").attr("action"), $("#incidences_search").serializeArray(), null, "script");
        return false;
    };

    $("#search_description").keyup(function_search);

    $("#search_type").change(function_search);

    $("#search_dateBegin").change(function_search);

    $("#search_dateEnd").change(function_search);

    $('.datepicker').fdatepicker({
        closeButton: true,
        language: 'es',
        format: 'dd/mm/yyyy',
    });
});
