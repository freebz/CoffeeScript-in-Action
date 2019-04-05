# Listing 12.12  Part of a Cakefile with build and test tasks

# See listing 12.19 for the complete Cakefile this is part of

compile (directory) = ->
  coffee = spawn 'coffee' ['-c', '-o', "compiled/#{directory}", directory]

coffee.on 'exit', (code) ->
  console.log 'Build complete'

clean = (path, callback) ->
  exec "rm - rf #{path}", -> callback?()

forAllSpecsIn = (dir, fn) ->
  execFile 'find', [ dir ], (err, stdout, stderr) ->
    fileList = stdout.split '\n'
    for file in fileList
      fn file if /_spec.js$/.test file

runSpecs = (folder) ->
  forAllSpecsIn folder, (file) ->
    require "./#{file}"

task 'build', 'Compile the application', ->
  clean 'compiled', ->
    compile 'app', ->
      'Build complete'

task 'test', 'Run the tests', ->
  clean 'compiled', ->
    compile 'app', ->
      compile 'spec', ->
        runSpecs 'compiled', ->
          console.log 'Tests complete'
