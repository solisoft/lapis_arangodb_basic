local lapis = require("lapis")
local http = require("lapis.nginx.http")
local console = require("lapis.console")
local assert_error, capture_errors, respond_to, yield_error
do
  local _obj_0 = require("lapis.application")
  assert_error, capture_errors, respond_to, yield_error = _obj_0.assert_error, _obj_0.capture_errors, _obj_0.respond_to, _obj_0.yield_error
end
local assert_valid
assert_valid = require("lapis.validate").assert_valid
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/console"] = console.make(),
    ["/"] = function(self)
      local body, status_code, headers = http.simple("https://solicms.com/en/demo/demo2")
      return "Welcome to Lapis " .. tostring(require("lapis.version")) .. " ... ..."
    end,
    ["/:name"] = capture_errors(function(self)
      local _ = {
        on_error = function(self)
          _ = "error"
          return {
            render = true
          }
        end
      }
      assert_valid(self.params, {
        {
          "name",
          exists = true,
          min_length = 2,
          max_length = 25
        }
      })
      return self:html(function()
        return h1("Hello " .. tostring(self.params.name))
      end)
    end)
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
