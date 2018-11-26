lapis = require "lapis"

import cached from require "lapis.cache"
import auth_arangodb, aql from require "lib.arango"

jwt = ""

splat_to_table = (splat) -> { k, v for k, v in splat\gmatch '/?(.-)/([^/]+)/?' }

-- App
class extends lapis.Application

  @before_filter =>
    if jwt == ""
      jwt = auth_arangodb!

  @include "controllers.crud"

  "/": cached {
    exptime: 0.2
    =>
      json: aql({
        query: "
          FOR doc IN objects
          LIMIT 3
          RETURN doc
        ",
        cache: true
      })
  }