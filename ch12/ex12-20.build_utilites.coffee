# Listing 12.20  Build utilities (build_utilites.coffee)

fs = require 'fs'
{spawn, exec, execFile, fork} = require 'child_process'

clientCompiled = false

forAllSpecsIn = (dir, fn) ->
  execFile 'find', [ dir ], (err, stdout, stderr) ->
    fileList = stdout.split '\n'
    for file in fileList
      fn file if /_spec.js$/.test file

compileClient = (callback) ->
  return callback() if clientCompiled
  clientCompiled = true
  compiler = require 'coffee-script'
  modules = fs.readFileSync "lib/modules.coffee", "utf-8"
  modules = compiler.compile modules, bare: true
  files = fs.readdirSync 'client'
  fs.mkdirSync "compiled/app/client"
  source = (for file in files when /\.coffee$/.test file
    module = file.replace /\.coffee/, ''
    fileSource = fs.readFileSync "client/#{file}", "utf-8"
    fs.writeFileSync "compiled/app/client/#{module}.js",
        compiler.compile fileSource
    """
    defmodule({#{module}: function (require, exports) {
      #{compiler.compile(fileSource, bare: true)}
    }});
    """
  ).join '\n\n'

  out = modules + '\n\n' + source
  fs.writeFileSync 'compiled/app/client/application.js', out

  callback?()

exports.fromDir = (root) ->

  return unless root

  compile = (path, callback) ->
    coffee = spawn 'coffee', ['-c', '-o', "#{root}compiled/#{path}", path]

    coffee.on 'exit', (code, s) ->
      if code is 0 then compileClient callback
      else console.log 'error compiling'

    coffee.on 'message', (data) ->
      console.log data

  createArtifact = (path, version, callback) ->
    execFile "tar", ["-cvf", "artifact.#{version}.tar", path], (e, d) ->
      callback?()

  runSpecs = (folder) ->
    forAllSpecsIn "#{root}#{folder}", (file) ->
      require "./#{file}"

  clean = (path, callback) ->
    exec "rm -r #{root}#{path}", (err) -> callback?()

  copy = (src, dst, callback) ->
    exec "cp -R #{root}#{src} #{root}#{dst}/.", ->
      callback?()

  runApp = (env) ->
    exec 'NODE_ENV=#{env} node compiled/app/server.js &', ->
      console.log "RUnning..."

  {clean, compile, copy, createArtifact, runSpecs, runApp}
