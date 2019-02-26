# Listing 9.4  Phone book with data loaded from event stream

fs = require 'fs'
{EventEmitter} = require 'events'

withEvents = (emitter, event) ->
  pipeline = []
  data = []

  reset = ->
    pipeline = []

  run = ->
    result = data
    for processor in pipeline
      if processor.filter?
        result = result.filter processor.filter
      else if processor.map?
        result = result.map processor.map
    result

  emitter.on event, (datum) ->
    data.push datum

  filter: (filter) ->
    pipeline.push {filter: filter}
    @
  map: (map) ->
    pipeline.push {map: map}
    @
  evaluate: ->
    result = run()
    reset()
    result

class CSVRowEmitter extends EventEmitter

  valid = (row) ->
    /[^,]+,[^,]+,[^,]+/.test row

  constructor: (source) ->
    @remainder = ''
    @numbers = []
    stream = fs.createReadStream source, {flags: 'r', encoding: 'utf-8'}
    stream.on 'data', (data) =>
      chunk = data.split /\n/
      firstRow = chunk[0]
      lastRow = chunk[chunk.length-1]
      if not valid firstRow and @remainder
        chunk[0] = @remainder + firstRow
      if not valid lastRow
        @remainder = lastRow
        chunk.pop()
      else @remainder = ''

      @emit('row', row) for row in chunk when valid row

class PhoneBook
  asObject = (row) ->
    [name, number, relationship] = row.split ','
    { name, number, relationship }

  asString = (data) ->
    "#{data.name}: #{data.number} (#{data.relationship})"

  print = (s) ->
    s.join '\n'

  relationshipIs = (relationship) ->
    (data) -> data.relationship is relationship

  nameIs = (name) ->
    (data) -> data.name is name

  constructor: (sourceCsv) ->
    csv = new CSVRowEmitter sourceCsv
    @numbers = withEvents(csv, 'row')

  list: (relationship) ->
    evaluated = \
    if relationship
      @numbers
      .map(asObject)
      .filter(relationshipIs relationship)
      .evaluate()
    else
      @numbers
      .map(asObject)
      .evaluate()

    print(asString data for data in evaluated)

  get: (name) ->
    evaluated = \
    @numbers
    .map(asObject)
    .filter(nameIs name)
    .evaluate()

    print(asString data for data in evaluated)

console.log "Phonebook. Commands are get, list and exit."

process.stdin.setEncoding 'utf8'
stdin = process.openStdin()

phonebook = new PhoneBook 'phone_number.csv'

stdin.on 'data', (chunk) ->
  args = chunk.split ' '
  command = args[0].trim()
  name = relationship = args[1].trim() if args[1]
  console.log switch command
    when 'get'
      phonebook.get name
    when 'list'
      phonebook.list relationship
    when 'exit'
      process.exit 1
    else 'Unknown command'
