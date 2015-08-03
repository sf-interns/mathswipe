Tuple    = require '../models/Tuple'

class AdjacentCellsCalculator

  # Gets valid adjacent placements in solutionGrid
  @getAdjacent: (solutionGrid, x, y) ->
    cells = []
    for i in [x - 1, x, x + 1]
      for j in [y - 1, y, y + 1]
        unless (i is x and j is y)
          tuple = @validLocation solutionGrid, i, j
          cells.push tuple unless tuple is null
    cells

  @validLocation: (solutionGrid, x, y) ->
    if @isValidIndex solutionGrid x, y
      return (new Tuple x, y) if (@isEmpty solutionGrid, x, y)
    null

  @isValidIndex: (solutionGrid, x, y) ->
    return x < solutionGrid.length and x >= 0 and
      y < solutionGrid.length and y >= 0

  @isEmpty: (solutionGrid, x, y) ->
    return solutionGrid[y][x].value is ' '

module.exports = AdjacentCellsCalculator
