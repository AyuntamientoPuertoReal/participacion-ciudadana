$(function () {
    $("#search").keyup(function () {
        $.get($("#staffs_search").attr("action"), $("#staffs_search").serialize(), null, "script");
        return false;
    });
});