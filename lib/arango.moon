http  = require "lapis.nginx.http"
config = require("lapis.config").get!

import from_json, to_json from require "lapis.util"

jwt = ""

-- auth_arangodb
auth_arangodb = ->
  body, status_code, headers = http.simple {
    url: config.db_url .. "_open/auth",
    method: "POST",
    body: to_json({
      username: config.db_login,
      password: config.db_pass
    })
  }
  if status_code == 200
    jwt = from_json(body)["jwt"]

  jwt

-- aql
aql = (stm)->
  -- create the cursor
  body, status_code, headers = http.simple {
    url: config.db_url .. "_db/#{config.db_name}/_api/cursor",
    method: "POST",
    body: to_json(stm),
    headers: {
      Authorization: "bearer #{jwt}"
    }
  }
  -- loop if has_more
  res = from_json(body)
  result = res["result"]
  has_more = res["has_more"]
  while has_more
    body, status_code, headers = http.simple {
      url: endpoint .. "_db/#{config.db_name}/_api/next/#{res["id"]}",
      method: "PUT",
      headers: {
        Authorization: "bearer #{jwt}"
      }
    }
    more = from_json(body)
    result += more["result"]
    has_more = more["has_more"]

  -- return the result
  result

-- expose method
{ :auth_arangodb, :aql }