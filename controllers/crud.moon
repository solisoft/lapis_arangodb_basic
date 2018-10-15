-- nothing here ... just a controller sample
lapis = require "lapis"
http  = require "lapis.nginx.http"

import respond_to, capture_errors from require "lapis.application"
import aql from require "lib.arango"

class extends lapis.Application

  [cruds: "/crud/:type(/*)"]: =>
    objects or= @params
    json: objects

  [crud: "/crud/:type/:key"]: respond_to {
    GET: =>
      -- Load an object
      json: { my: 'object' }
    PUT: =>
      -- Update an object
      json: { my: 'updated object' }
    DELETE: =>
      -- Delete an object
      json: { success: true }
  }
