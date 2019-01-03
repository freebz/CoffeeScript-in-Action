# Listing 4.3  Comprehension compared to for...in loop

# CoffeeScript

movie =
  title: 'From Dusk till Dawn'
  released: '1996'
  director: 'Robert Rodriguez'
  writer: 'Quentin Tarantino'

for property of movie
  console.log property
