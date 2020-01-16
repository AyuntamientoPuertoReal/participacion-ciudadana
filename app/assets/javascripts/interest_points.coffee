changeMap = -> 
  $("#into_map").click ->
    latitud = document.getElementById("inp_latitud").value
    longitud = document.getElementById("inp_longitud").value
    base_html_map = "https://maps.google.com/maps?q="+latitud+","+longitud+"&t=&z=13&ie=UTF8&iwloc=&output=embed"
    $("#gmap_canvas").attr("src",base_html_map)
    
$(document).on('turbolinks:load', changeMap)

