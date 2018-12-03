# Listing 3.2  Count words comparison

# CoffeeScript

countWords = (s, del) ->
  if s
    words = s.split del
    words.length
  else
    0


# JavaScript

var countWords = function (s, del) {
  var words;
  if (s) {
    words = s.split(del);
    return words.length;
  } else {
    return 0;
  }
}
