local http = require("lapis.nginx.http")
local config = require("lapis.config").get()
local from_json, to_json
do
  local _obj_0 = require("lapis.util")
  from_json, to_json = _obj_0.from_json, _obj_0.to_json
end
local jwt = ""
local auth_arangodb
auth_arangodb = function()
  local body, status_code, headers = http.simple({
    url = config.db_url .. "_open/auth",
    method = "POST",
    body = to_json({
      username = config.db_login,
      password = config.db_pass
    })
  })
  if status_code == 200 then
    jwt = from_json(body)["jwt"]
  end
  return jwt
end
local aql
aql = function(stm)
  local body, status_code, headers = http.simple({
    url = config.db_url .. "_db/" .. tostring(config.db_name) .. "/_api/cursor",
    method = "POST",
    body = to_json(stm),
    headers = {
      Authorization = "bearer " .. tostring(jwt)
    }
  })
  local res = from_json(body)
  local result = res["result"]
  local has_more = res["has_more"]
  while has_more do
    body, status_code, headers = http.simple({
      url = endpoint .. "_db/" .. tostring(config.db_name) .. "/_api/next/" .. tostring(res["id"]),
      method = "PUT",
      headers = {
        Authorization = "bearer " .. tostring(jwt)
      }
    })
    local more = from_json(body)
    result = result + more["result"]
    has_more = more["has_more"]
  end
  return result
end
return {
  auth_arangodb = auth_arangodb,
  aql = aql
}
