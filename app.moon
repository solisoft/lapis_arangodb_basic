lapis = require "lapis"
http = require "lapis.nginx.http"

console = require "lapis.console"

import
  assert_error
  capture_errors
  respond_to
  yield_error
  from require "lapis.application"
  
import assert_valid from require "lapis.validate"

class extends lapis.Application
  
  "/console": console.make!
  "/": =>
    body, status_code, headers = http.simple "https://solicms.com/en/demo/demo2"

    "Welcome to Lapis #{require "lapis.version"} ... ..."

  "/:name": capture_errors =>
    on_error: =>
     "error"
     render: true

    assert_valid @params, {
      { "name", exists: true, min_length: 2, max_length: 25}
    }
    
    @html ->
        h1 "Hello #{@params.name}"
    