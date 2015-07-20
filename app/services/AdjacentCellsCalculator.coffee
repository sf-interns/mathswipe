Tuple = require "../models/Tuple"

class AdjacentCellsCalculator

  # Param grid is a GameGrid
  constructor: (@grid, @cells, @x, @y) ->

  # Gets the adjacent cells
  calculate: () => 
    for i in [@y - 1, @y, @y + 1]
      for j in [@x - 1, @x, @x + 1]
        continue if i is @y and j is @x
        @cells.push @validLocation @grid, i, j
    @cells

  # returns a valid location if it exists, otherwise null
  validLocation: (grid,x,y) =>
    while grid.validIndices x, y
      return new Tuple x, y if @empty grid, x, y
      y--
    null

  empty: (grid,x,y) => grid.at x, y is null

module.exports = AdjacentCellsCalculator
