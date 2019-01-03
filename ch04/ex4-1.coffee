# Listing 4.1  Comparison of YAML literal with brace literal notation

# YAML object literals

futurama =
  characters: [
    'Fry'
    'Leela'
    'Bender'
    'The Professor'
    'Scruffy'
  ]
  quotes: [
    'Good news everyonoe!'
    'Bite my shiny metal'
  ]


# Brace object literals

futurama = {
  characters: [
    'Fry',
    'Leela',
    'Bender',
    'The Professor',
    'Scruffy'
  ],
  quotes: [
    'Good news everyone!',
    'Bite my shiny metal'
  ]
}
