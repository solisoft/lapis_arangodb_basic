local lapis = require("lapis")
local http = require("lapis.nginx.http")
local respond_to, capture_errors
do
  local _obj_0 = require("lapis.application")
  respond_to, capture_errors = _obj_0.respond_to, _obj_0.capture_errors
end
local aql
aql = require("lib.arango").aql
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    [{
      cruds = "/crud/:type(/*)"
    }] = function(self)
      local objects = objects or self.params
      return {
        json = objects
      }
    end,
    [{
      crud = "/crud/:type/:key"
    }] = respond_to({
      GET = function(self)
        return {
          json = aql({
            query = "\n          FOR doc IN objects\n          LIMIT 10\n          RETURN doc\n        ",
            cache = true
          })
        }
      end,
      PUT = function(self)
        return {
          json = {
            my = 'updated object'
          }
        }
      end,
      DELETE = function(self)
        return {
          json = {
            success = true
          }
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
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  return _class_0
end
