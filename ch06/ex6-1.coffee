# Listing 6.1  Profit from selling PhotomakerExtreme

proofit = (salePrice) ->
  overhead = 140
  costPrice = 100
  numberSold = (salePrice) ->
    50 + 20/10 * (200 - salePrice)
  revenue = (salePrice) ->
    (numberSold salePrice) * salePrice
  cost = (salePrice) ->
    overhead + (numberSold salePrice) * costPrice

  (revenue salePrice) - (cost salePrice)
