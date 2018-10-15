lapis = require "lapis"
http  = require "lapis.nginx.http"

import respond_to, capture_errors from require "lapis.application"
import aql from require "lib.arango"

class extends lapis.Application

  [cruds: "/crud/:type(/*)"]: =>
    -- Run the AQL request
    -- objects = aql("
    --   FOR doc IN FILTER doc.type == @type RETURN doc
    -- ", {
    -- type: @params.type
    --})
    -- Return objects
    objects or= @params
    json: objects

  [crud: "/crud/:type/:key"]: respond_to {
    GET: =>
      -- Load an object
      json: aql({
        query: "
          FOR doc IN objects
          LIMIT 10
          RETURN doc
        ",
        cache: true
      })

    PUT: =>
      -- Update an object
      json: { my: 'updated object' }
    DELETE: =>
      -- Delete an object
      json: { success: true }
  }
