# Listing 6.3  Local state and shared state

numberSold = 0

calculateNumberSold = (salePrice) ->
  numberSold = 50 + 20/10 * (200 - salePrice)

calculateRevenue = (salePrice, callback) ->
  callback numberSold * salePrice

revenueBetween = (start, finish) ->
  totals = []
  for price in [start..finish]
    calculateNumberSold price
    addToTotals = (result) ->
      totals.push result
    calculateRevenue price, addToTotals
  totals

revenueBetween 140, 145
# [ 23800, 23688, 23572, 23452, 23328, 23200 ]
