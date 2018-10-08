lapis = require "lapis"
http = require "lapis.nginx.http"

console = require "lapis.console"

import assert_valid from require "lapis.validate"

class extends lapis.Application
  
  "/console": console.make!
  "/": =>
    "Welcome to Lapis #{require "lapis.version"}"