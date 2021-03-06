# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creación del token de Apicasso.
unless Apicasso::Key.exists?
  print "Creación del token de Apicasso... "
  Apicasso::Key.create(scope:
                           { read:
                                {
                                  incidence: true,
                                  phone_identifier: true,
                                  interest_point: true,
                                  incidence_type: true,
                                  incidence_tracking: true,
                                  news: true
                                },
                             create:
                                {
                                  incidence: true,
                                  phone_identifier: true
                                },
                             update:
                                {
                                  phone_identifier: true
                                } })
  puts "✔"
end

# Creación de los roles administrativos.
are_new_roles = false

Role.find_or_create_by(name: "Administrador") do |r|
  are_new_roles = true
end

Role.find_or_create_by(name: "Supervisor") do |r|
  are_new_roles = true
end

Role.find_or_create_by(name: "Técnico") do |r|
  are_new_roles = true
end

if are_new_roles
  puts "Creando roles... ✔"
end

# Creación del usuario administrador. ¡Cambiar email y contraseña lo primero de todo!
@admin_user

if Staff.find_by(username: "administrador").nil?
  print "Creando usuario administrador... "
  @admin_user = Staff.new(username: "administrador",
                         email: "administrador@participacionciudadana.com",
                         password: "12345678",
                         password_confirmation: "12345678",
                         full_name: "Administración Participación Ciudadana",
                         can_publish: true,
                         is_web_editor: true)
  @admin_user.save!
  puts "✔"
end

# Asignando al administrador su rol.
if @admin_user != nil && @admin_user.role.blank?
  print "Asignando al administrador su rol correspondiente... "
  @admin_user.role = Role.find_by(name: "Administrador")
  @admin_user.save!
  puts "✔"
end

# Tipos de incidencias
are_new_incidence_types = false

@seed_incidences = Array.new

it1 = IncidenceType.find_or_create_by(code: "PAR",
                                      name: "Parques y Jardines",
                                      description: "Incidencias sobre Parques y Jardines") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it1)

it2 = IncidenceType.find_or_create_by(code: "INF",
                                      name: "Infraestructura",
                                      description: "Incidencias sobre Infraestructura") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it2)

it3 = IncidenceType.find_or_create_by(code: "LIM",
                                      name: "Limpieza",
                                      description: "Incidencias sobre Limpieza") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it3)

it4 = IncidenceType.find_or_create_by(code: "ILU",
                                      name: "Iluminación",
                                      description: "Incidencias sobre Iluminación") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it4)


it5 = IncidenceType.find_or_create_by(code: "RES",
                                      name: "Recogida de Residuos",
                                      description: "Incidencias sobre la Recogida de Residuos") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it5)

it6 = IncidenceType.find_or_create_by(code: "AMB",
                                      name: "Medio Ambiente",
                                      description: "Incidencias sobre Medioambiente") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it6)

it7 = IncidenceType.find_or_create_by(code: "SAN",
                                      name: "Saneamiento",
                                      description: "Incidencias sobre Saneamiento") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it7)

it8 = IncidenceType.find_or_create_by(code: "GEN",
                                      name: "General",
                                      description: "Incidencias Generales") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it8)

it9 = IncidenceType.find_or_create_by(code: "ACC",
                                      name: "Accesibilidad",
                                      description: "Incidencias sobre accesibilidad") do |it|
  are_new_incidence_types = true
end
@seed_incidences.push(it9)

if are_new_incidence_types
  puts "Creando los tipos de incidencias... ✔"
end

@last_order = IncidenceType.all.pluck(:order).compact.max

if @last_order.nil?
  @last_order = 0
end

are_orderless_incidence_types = false

@seed_incidences.each do |it|
  if it.order.nil?
    are_orderless_incidence_types = true
    @last_order += 1
    it.order = @last_order
    it.save
  end
end

if are_orderless_incidence_types
  puts "Asignando orden a los tipos de incidencias... ✔"
end

# Puntos de interés
are_new_interest_points = false

InterestPoint.find_or_create_by(name: "Ayuntamiento - Casa Consistorial",
                                latitude: "36.52866345",
                                longitude: "-6.143663",
                                image_url: "https://puertorealhoy.es/wp-content/uploads/2016/04/20160422_ayuntamiento_plaza_jesus_puerto_real.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "IMPRO",
                                latitude: "36.526096",
                                longitude: "-6.178938",
                                image_url: "http://www.puertorealweb.es/spip2/IMG/arton18921.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "OMIC",
                                latitude: "36.527724",
                                longitude: "-6.19251",
                                image_url: "https://www.puertorealhoy.es/wp-content/uploads/2014/05/2014_pr_centro_administrativo_mpal.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Ayuntamiento - Centro Administrativo Municipal",
                                latitude: "36.52579575",
                                longitude: "-6.19104836",
                                image_url: "https://www.estudiosegui.com/wp-content/uploads/2017/02/01_Ayto-Puerto-Real-min.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Centro Cívico Barrio de Jarana",
                                latitude: "36.503815",
                                longitude: "-6.143663",
                                image_url: "http://www.puertorealweb.es/spip2/IMG/arton2273.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Centro Cívico Ciudad Abierta",
                                latitude: "36.526219",
                                longitude: "-6.180167",
                                image_url: "https://www.puertorealhoy.es/wp-content/uploads/2014/08/20140819_local_centro_civico_cj.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Centro Cívico Rio San Pedro",
                                latitude: "36.523887",
                                longitude: "-6.223658",
                                image_url: "https://www.diariodecadiz.es/2009/09/26/noticias-provincia-cadiz/Imagen-Centro-Civico-San-Pedro_299680208_28527567_1545x1024.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Sala de Barrio 512",
                                latitude: "36.53249",
                                longitude: "-6.197565",
                                image_url: "https://s3.static-clubeo.com/uploads/sdcandray/grounds/sala-de-barrio-512__oekely.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Sala Barrio Río San Pedro",
                                latitude: "36.523829",
                                longitude: "-6.232195",
                                image_url: "https://s2.static-clubeo.com/uploads/sdcandray/grounds/sala-de-barrio-rio-san-pedro__oekete.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Centro Cultural Iglesia de San José",
                                latitude: "36.528821",
                                longitude: "-6.190772",
                                image_url: "https://andaluciarustica.com/wp-content/uploads/2017/05/puerto-real-iglesia-de-san-jose.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

InterestPoint.find_or_create_by(name: "Centro de Servicios Sociales 512",
                                latitude: "36.53136",
                                longitude: "-6.19696",
                                image_url: "http://epsuvi.com/web/wp-content/uploads/2018/11/sala_barrio.jpg",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis, massa vel ornare viverra, metus ex laoreet purus, vel maximus nibh est quis risus. Praesent euismod ultricies congue. Duis ut consequat nisi. Quisque vehicula dapibus nibh, vel rhoncus enim hendrerit a. Ut dictum, lacus ac eleifend bibendum, turpis diam pharetra libero, non eleifend arcu felis quis lectus. Aliquam erat volutpat. Sed nec efficitur nisl. Donec in ligula est. Vestibulum malesuada nec tortor in sollicitudin. Phasellus ultrices consequat ex, consectetur finibus nunc consequat vel. Donec blandit et sem et aliquam. Quisque ac turpis ut arcu placerat venenatis.") do |ip|
  are_new_interest_points = true
end

if are_new_interest_points
  puts "Creando los puntos de interés... ✔"
end

# Noticias de prueba
# print "Creando las noticias de prueba... "
# News.find_or_create_by(title: "Jornadas gratuitas",
#                        description: "Nuevas fuentes de financiación para entidades sin ánimo de lucro",
#                        body: "<img src='https://i.imgur.com/yiIUH1w.jpg'/><p>El Ayuntamiento de Puerto Real, dentro del programa Andalucía Compromiso Digital, iniciativa de la Consejería de Economía, Conocimiento, Empresas y Universidad, puesta en marcha en el año 2007, organiza para el público en general y en especial para asociaciones y entidades sin ánimo de lucro, la jornada gratuita \"Nuevas fuentes de financiación para entidades sin ánimo de lucro\"...</br></br>Los interesados en inscribirse en estas jornadas gratuitas pueden acudir bien a la Casa de la Juventud, bien a la U.G. Feminismos-LGTBI (Centro de Servicios Sociales, C/ Zambra 4), o llamar a los teléfonos 856 21 33 81 ó 856 21 33 39. La admisión será por orden de llegada y las plazas son limitadas. </p><br />",
#                        image_url: "https://decide.puertoreal.es/assets/logo_header-b43bade3f054a60247722d7de1023275c70d559375b6efb60d210389ea70c081.png",
#                        published: true,
#                        author: Staff.find_by(username: "administrador"))
# News.find_or_create_by(title: "El Teatro Principal acogerá el jueves una Jornada Provincial de Participación Ciudadana",
#                        description: "El objetivo genérico de la jornada es analizar la Ley Andaluza de Participación Ciudadana, con especial atención a determinados aspectos concretos, como la aplicación en los municipios",
#                        body: "<img src='https://www.puertorealhoy.es/wp-content/uploads/2019/11/20191121_cartel_jornada_participacion_ciudadana_cadiz.jpg'/><p>Puerto Real será la semana que viene el epicentro de la participación ciudadana gracias la celebración en la localidad de una jornada formativa de la nueva ley andaluza que regula los mecanismos y herramientas de las que dispone la ciudadanía para implicarse en la gestión pública.</p><p>Hoy ha sido presentada esta Jornada, que ha contado con la presencia de la diputada provincial de Desarrollo Democrático, Lucía Trujillo Llamas, acompañando a la alcaldesa, Elena Amaya, y al responsable municipal de Participación Ciudadana, el teniente de alcaldesa Manuel Jesús Izco.</p><p>Izco ha valorado la celebración en la ciudad de esta Jornada, por cuanto “en esta área municipal estamos introduciendo cambios con respecto al anterior mandato, recuperando espacios de participación, como los foros, y también creando otros nuevos, como el que van a protagonizar las barriadas rurales. Por eso, tener aquí a responsables políticos y técnicos, asociaciones y personas que trabajan en este campo resulta muy beneficioso para nosotros”.</p><p>El primer día del próximo año 2020 entrará en vigor la Ley 7/2017 de Participación Ciudadana en el ámbito de Andalucía, y por ello resulta necesario que tanto las administraciones públicas andaluzas y los colectivos, así como también los particulares, asuman los retos que supone esta normativa. Así lo ha puesto de manifiesto la diputada provincial Lucía Trujillo, quien estima que esta renovada disposición “garantiza el derecho de la ciudadanía a participar activamente en la vida pública”.</p><p>La alcaldesa Elena Amaya, por su parte, ha agradecido a la Diputación de Cádiz haber contado con la ciudad para que acogiera esta formación tan oportuna, “esperando que contribuya a que Puerto Real y el resto de los municipios de la provincia estén plenamente preparados para asumir las necesidades de la ciudadanía de implicarse, pero también las propias administraciones, que precisan del contacto permanente con la vida de la gente”.</p><p>El objetivo genérico de la jornada es analizar la Ley Andaluza de Participación Ciudadana, con especial atención a determinados aspectos concretos, como la aplicación en los municipios. En este sentido, quienes acudan podrán conocer las nuevas herramientas y procesos para la puesta en marcha de proyectos de Participación Ciudadana en el ámbito local. De este modo, se pretende conseguir que la ciudadanía tenga las mismas oportunidades para opinar, expresarse y participar en condiciones de igualdad en los asuntos públicos.</p><p>Sin duda una excelente oportunidad para saber cómo afrontar el tránsito de los tradicionales patrones hacia nuevos modelos de participación en los que las administraciones locales ocupen un papel de liderazgo y mediación.</p><p>La acción formativa se desarrollará el próximo jueves 28 de noviembre desde las 9:00 horas en dos edificios municipales: en el Teatro Principal, donde tendrán lugar la inauguración, la mesa redonda y la clausura, y en el Centro Cultural del Paseo Marítimo, ubicación de los talleres simultáneos.</p><p>Para inscribirse de manera gratuita en esta Jornada la Diputación Provincial ha habilitado un enlace online desde el que hacerlo cómodamente, aunque también podrán acudir a la Oficina de Participación Ciudadana sita en la Casa Consistorial de la Plaza de Jesús.</p>",
#                        image_url: "https://www.puertorealhoy.es/wp-content/uploads/2019/11/20191121_cartel_jornada_participacion_ciudadana_cadiz.jpg",
#                        published: true,
#                        author: Staff.find_by(username: "administrador"))
# puts "✔"

# Registros cero.
are_new_zero_registers = false

PhoneIdentifier.find_or_create_by(phone_identifier: "0000000000")
Incidence.find_or_create_by(description: "Incidencia inicial",
                            image_url: "https://i.blogs.es/a19bfc/testing/1366_2000.jpg",
                            phone_identifier: PhoneIdentifier.find_by(phone_identifier: "0000000000"),
                            latitude: "36.5287359",
                            longitude: "-6.1927982",
                            incidence_type: IncidenceType.find_by(code: "PAR")) do |i|
  are_new_zero_registers = true
end
IncidenceTracking.find_or_create_by(incidence: Incidence.find_by(description: "Incidencia inicial"),
                                    staff: Staff.find_by(username: "administrador"),
                                    processing_units: "Administración del sistema",
                                    status: 1,
                                    previous_status: 1,
                                    message: "Esto es una incidencia inicial de prueba.") do |it|
  are_new_zero_registers = true
end

if are_new_zero_registers
  puts "Creando los registros iniciales... ✔"
end

if (!Rpush::Gcm::App.find_by_name("appparticipacion_droid"))
  print "Registrando la app móvil para las notificaciones... "
  app = Rpush::Gcm::App.new
  # let's name this one pushme_droid
  app.name = "appparticipacion_droid"
  # FCM auth key from firebase project
  app.auth_key = Rails.application.credentials.fcm_auth_key
  app.connections = 1
  # save our app in db
  app.save
  puts "✔"
end

puts "Todas las tareas finalizaron exitosamente."