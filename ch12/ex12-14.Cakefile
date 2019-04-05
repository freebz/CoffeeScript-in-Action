# Listing 12.14  Cake task for client-side modules

task 'build:client', 'build client side stuff with modules', ->
  compiler = require 'coffee-script'
  modules = fs.readFileSync "lib/modules.coffee", "utf-8"

  modules = compiler.compile modules, bare: true
  files = fs.readdirSync 'client'
  source = (for file in files when /\.coffee$/.test file
    fileSource = fs.readFileSync "client/#{file}", "utf-8"

    """
    defmodule({#{module}: function (require, exports) {
      #{compiler.compile(fileSource, bare: true)}
    }});
    """
  ).join '\n\n'

  out = modules + '\n\n' + source
  fs.writeFileSync 'compiled/app/client/application.js'
