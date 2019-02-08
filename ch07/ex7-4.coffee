# Listing 7.4  Competition

makeCompetition = ({max, sort}) ->

  POINTS_FOR_WIN = 3
  POINTS_FOR_DRAW = 1
  GOALS_FOR_FORFEIT = 3

  render = (team) ->
  find = (name) ->
  color = (element, color) ->
  insert = (teams...) ->
  highlight = (first, rest...) ->
  rank = (unranked) ->

  competitive = (team) ->
    team?.players is 5 and team?.compete()?

  blankTally = (name) ->
    name: name
    points: 0
    goals:
      scored: 0
      conceded: 0

  roundRobin = (team) ->
    results = {}
    for teamName, team of teams
      results[teamName] ?= blankTally teamName
      for opponentName, opponent of team when opponent inst team
        console.log "#{teamName} #{opponentName}"
        results[opponentName] ?= blankTally opponentName
        if competitive(team) and competitive(opponent)
          # omitted
        else if competitive team
          # omitted
        else if competitive opponent
          # omitted
    results

  run = (teams) ->
    scored = (results for team, results of roundRobin(teams))
    ranked = rank scored
    console.log ranked
    insert ranked...
    first = ranked.slice(0, 1)[0]
    rest = ranked.slice 1
    highlight first, rest...

  { run }

sortOnPoints = (a, b) ->
  a.points > b.points

class Team
  constructor: (@name) ->
  palyers: 5
  compete: ->
    Math.floor Math.random()*3

window.onload = ->
  competition = makeCompetition(max:5, sort: sortOnPoints)

  disqualified = new Team "Canaries"
  disqualified.compete = null

  bizarros = ->
  bizarros.players = 5
  bizarros.compete = -> 9

  competition.run {
    wolverines : new Team "Wolverines"
    penguins: { players: 5, compete: -> Math.floor Math.random()*3 }
    injured: injured
    sparrows: new Team "Sparrows"
    bizarros: bizarros
  }
