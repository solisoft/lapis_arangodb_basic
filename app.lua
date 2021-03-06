local lapis = require("lapis")
local cached
cached = require("lapis.cache").cached
local auth_arangodb, aql
do
  local _obj_0 = require("lib.arango")
  auth_arangodb, aql = _obj_0.auth_arangodb, _obj_0.aql
end
local jwt = ""
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/"] = cached({
      exptime = 0.2,
      function(self)
        return {
          json = aql({
            query = "\n          FOR doc IN objects\n          LIMIT 3\n          RETURN doc\n        ",
            cache = true
          })
        }
      end
    })
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = nil,
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self:before_filter(function(self)
    if jwt == "" then
      jwt = auth_arangodb()
    end
  end)
  self:include("controllers.crud")
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  return _class_0
end
