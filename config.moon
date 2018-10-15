-- config.moon
config = require "lapis.config"

config "development", ->
  port 8080
  db_url "http://172.30.0.6:8529/"
  db_name "cms"
  db_login "root"
  db_pass  "password"

config "production", ->
  port 80
  num_workers 4
  code_cache "on"
  measure_performance true
  db_url "http://172.30.0.6:8529/"
  db_name "cms"
  db_login "root"
  db_pass  "password"
