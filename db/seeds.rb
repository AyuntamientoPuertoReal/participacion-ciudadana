# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Token de Apicasso
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
                               }
                         })

# Tipos de incidencias
IncidenceType.create(code: "PAR", name: "Parques y Jardines", description: "Incidencias sobre Parques y Jardines", order: 1)
IncidenceType.create(code: "INF", name: "Infraestructura", description: "Incidencias sobre Infraestructura", order: 2)
IncidenceType.create(code: "LIM", name: "Limpieza", description: "Incidencias sobre Limpieza", order: 3)
IncidenceType.create(code: "ILU", name: "Iluminación", description: "Incidencias sobre Iluminación", order: 4)
IncidenceType.create(code: "RES", name: "Recogida de Residuos", description: "Incidencias sobre la Recogida de Residuos", order: 5)
IncidenceType.create(code: "AMB", name: "Medio Ambiente", description: "Incidencias sobre Medioambiente", order: 6)
IncidenceType.create(code: "SAN", name: "Saneamiento", description: "Incidencias sobre Saneamiento", order: 7)
IncidenceType.create(code: "GEN", name: "General", description: "Incidencias Generales", order: 8)