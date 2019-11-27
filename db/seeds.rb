# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creación del usuario administrador. ¡Cambiar email y contraseña lo primero de todo!
unless Staff.any?
  print "Creando usuario administrador... "
  admin = Staff.new(username: "administrador", email: "administrador@participacionciudadana.com", password: "12345678", password_confirmation: "12345678", full_name: "Administración Participación Ciudadana",
                    can_publish: true, is_web_editor: true)
  admin.save!
  puts "✔"
end

# Tipos de incidencias
unless IncidenceType.any?
  print "Creando los tipos de incidencias... "
  IncidenceType.create(code: "PAR", name: "Parques y Jardines", description: "Incidencias sobre Parques y Jardines", order: 1)
  IncidenceType.create(code: "INF", name: "Infraestructura", description: "Incidencias sobre Infraestructura", order: 2)
  IncidenceType.create(code: "LIM", name: "Limpieza", description: "Incidencias sobre Limpieza", order: 3)
  IncidenceType.create(code: "ILU", name: "Iluminación", description: "Incidencias sobre Iluminación", order: 4)
  IncidenceType.create(code: "RES", name: "Recogida de Residuos", description: "Incidencias sobre la Recogida de Residuos", order: 5)
  IncidenceType.create(code: "AMB", name: "Medio Ambiente", description: "Incidencias sobre Medioambiente", order: 6)
  IncidenceType.create(code: "SAN", name: "Saneamiento", description: "Incidencias sobre Saneamiento", order: 7)
  IncidenceType.create(code: "GEN", name: "General", description: "Incidencias Generales", order: 8)
  puts "✔"
end

# Puntos de interés
unless InterestPoint.any?
  print "Creando los puntos de interés... "
  InterestPoint.create(name: "Ayuntamiento - Casa Consistorial", latitude: "36.52866345", longitude: "-6.143663",
                       image_url: "https://puertorealhoy.es/wp-content/uploads/2016/04/20160422_ayuntamiento_plaza_jesus_puerto_real.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "IMPRO", latitude: "36.526096", longitude: "-6.178938",
                       image_url: "http://www.puertorealweb.es/spip2/IMG/arton18921.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "OMIC", latitude: "36.527724", longitude: "-6.19251",
                       image_url: "https://www.puertorealhoy.es/wp-content/uploads/2014/05/2014_pr_centro_administrativo_mpal.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Ayuntamiento - Centro Administrativo Municipal", latitude: "36.52579575", longitude: "-6.19104836",
                       image_url: "https://www.estudiosegui.com/wp-content/uploads/2017/02/01_Ayto-Puerto-Real-min.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Centro Cívico Barrio de Jarana", latitude: "36.503815", longitude: "-6.143663",
                       image_url: "http://www.puertorealweb.es/spip2/IMG/arton2273.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Centro Cívico Ciudad Abierta", latitude: "36.526219", longitude: "-6.180167",
                       image_url: "https://www.puertorealhoy.es/wp-content/uploads/2014/08/20140819_local_centro_civico_cj.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Centro Cívico Rio San Pedro", latitude: "36.523887", longitude: "-6.223658",
                       image_url: "https://www.diariodecadiz.es/2009/09/26/noticias-provincia-cadiz/Imagen-Centro-Civico-San-Pedro_299680208_28527567_1545x1024.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Sala de Barrio 512", latitude: "36.53249", longitude: "-6.197565",
                       image_url: "https://s3.static-clubeo.com/uploads/sdcandray/grounds/sala-de-barrio-512__oekely.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Sala Barrio Río San Pedro", latitude: "36.523829", longitude: "-6.232195",
                       image_url: "https://s2.static-clubeo.com/uploads/sdcandray/grounds/sala-de-barrio-rio-san-pedro__oekete.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Centro Cultural Iglesia de San José", latitude: "36.528821", longitude: "-6.190772",
                       image_url: "https://andattribute 'author' foaluciarustica.com/wp-content/uploads/2017/05/puerto-real-iglesia-de-san-jose.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  InterestPoint.create(name: "Centro de Servicios Sociales 512", latitude: "36.53136", longitude: "-6.19696",
                       image_url: "http://epsuvi.com/web/wp-content/uploads/2018/11/sala_barrio.jpg",
                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.")
  puts "✔"
end

# Noticias de prueba
unless News.any?
  print "Creando las noticias de prueba... "
  News.create(title: "Jornadas gratutitas", description: "Nuevas fuentes de financiación para entidades sin ánimo de lucro",
              body: "<img src='http://puertoreal.es/RIIM/RIIMTablonAnuncios.nsf/80c19f2667155d57c1256be50062e7c1/e203a2e5d1c6fe63c1258494002fb30f/$FILE/ACD.jpg'/><p>El Ayuntamiento de Puerto Real, dentro del programa Andalucía Compromiso Digital, iniciativa de la Consejería de Economía, Conocimiento, Empresas y Universidad, puesta en marcha en el año 2007, organiza para el público en general y en especial para asociaciones y entidades sin ánimo de lucro, la jornada gratuita \"Nuevas fuentes de financiación para entidades sin ánimo de lucro\"...</br></br>Los interesados en inscribirse en estas jornadas gratuitas pueden acudir bien a la Casa de la Juventud, bien a la U.G. Feminismos-LGTBI (Centro de Servicios Sociales, C/ Zambra 4), o llamar a los teléfonos 856 21 33 81 ó 856 21 33 39. La admisión será por orden de llegada y las plazas son limitadas. </p><br />",
              image_url: "https://decide.puertoreal.es/assets/logo_header-b43bade3f054a60247722d7de1023275c70d559375b6efb60d210389ea70c081.png",
              published: true, author: Staff.find(1), date_of_creation: DateTime.now)
  puts "✔"
end

puts "Todas las tareas finalizaron exitosamente."