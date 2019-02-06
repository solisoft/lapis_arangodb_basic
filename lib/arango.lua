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
local with_params
with_params = function(method, handle, params)
  local body, status_code, headers = http.simple({
    url = config.db_url .. "_db/" .. tostring(config.db_name) .. "/_api/document/" .. handle,
    method = method,
    body = to_json(params),
    headers = {
      Authorization = "bearer " .. tostring(jwt)
    }
  })
  return body
end
local without_params
without_params = function(method, handle)
  local body, status_code, headers = http.simple({
    url = config.db_url .. "_db/" .. tostring(config.db_name) .. "/_api/document/" .. handle,
    method = method,
    headers = {
      Authorization = "bearer " .. tostring(jwt)
    }
  })
  return body
end
local document_put
document_put = function(handle, params)
  return with_params("PUT", handle, params)
end
local document_post
document_post = function(collection, params)
  return with_params("POST", collection, params)
end
local document_get
document_get = function(handle)
  return without_params("GET", handle)
end
local document_delete
document_delete = function(handle)
  return without_params("DELETE", handle)
end
local transaction
transaction = function(params)
  local body, status_code, headers = http.simple({
    url = config.db_url .. "_db/" .. tostring(config.db_name) .. "/_api/transaction",
    method = method,
    body = to_json(params),
    headers = {
      Authorization = "bearer " .. tostring(jwt)
    }
  })
  return body
end
return {
  auth_arangodb = auth_arangodb,
  aql = aql,
  document_get = document_get,
  document_put = document_put,
  document_post = document_post,
  document_delete = document_delete,
  transaction = transaction
}
