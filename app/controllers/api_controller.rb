class ApiController < ApplicationController
  Apicasso::Key.create(scope:
                           { read:
                                 {
                                     incidence: true,
                                     token: true
                                 },
                             create:
                                 {
                                     incidence: true,
                                     token: true
                                 }
                           })
  end

