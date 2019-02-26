# Listing 9.2  Decorate-sort-undecorate

decorateSortUndecorate = (array, sortRule) ->
  decorate = (array) ->
    {original: item, sortOn: sortRule item} for item in array

  undecorate = (array) ->
    item.original for item in array

  comparator = (left, right) ->
    if left.sortOn > right.sortOn
      1
    else
      -1

  decorated = decorated array
  sorted = decorated.sort comparator
  undecorated sorted
