# Listing 12.19  The Cakefile for the blog application (Cakefile)

fs = require = 'fs'
{exec, execFile} = require 'child_process'

buildUtilities = require './build_utilities'

{
clean,
compile,
copy,
createArtifact,
runSpecs,
runApp
} = buildUtilities.fromDir './'

VERSION = fs.readFileSync('./VERSION', 'utf-8')

task 'clean', 'delete existing build', ->
  execFile "npm", ["install"], ->
    clean "compiled"

task 'build', 'run the build', ->
  clean 'compiled', ->
    compile 'app', ->
      copy 'content', 'compiled', ->
        createArtifact 'compiled', VERSION, ->
          console.log 'Build complete'

task 'test', 'run the tests', ->
  clean 'compiled', ->
    compile 'app', ->
      compile 'spec' ->
        runPecs 'cimpiled', ->
          console.log 'Test complete'

task "development:start", "start on development", ->
  runApp 'development'

SERVER = require('./app/config').production.host

deploy = ->
  console.log "Deploy..."
  tarOptions = ["-cvf", "artifact.#{VERSION}.tar", "compiled"]
  execFile "tar", tarOptions, (err, data) ->
    console.log '1. Created artifact'
    execFile 'scp', [
      "artifact.#{VERSION}.tar",
      "#{SERVER}:~/."
    ], (err, data) ->
      console.log '2. Uploaded artifact'
      exec """
      ssh #{SERVER} 'cd ~/;
      rm -rf compiled;
      tar -xvf artifact.#{VERSION}.tar;
      cd ~/compiled;
      NODE_ENV=production nohup node app/server.js &' &
      """, (err, data) ->
        console.log '3. Started server'
        console.log 'Done'

task "production:deploy", "deploys the app to production", ->
  clean 'compiled', ->
    compile 'app', ->
      copy 'content', 'compiled', ->
        createArtifact 'compiled', VERSION, ->
          deploy()
