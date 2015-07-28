Tuple    = require "../models/Tuple"
TupleSet = require "../models/TupleSet"

class AdjacentCellsCalculator

  # Param grid is a GameGrid
  constructor: (@grid, @cells=(new TupleSet), @x, @y) ->

  # Gets the adjacent cells
  calculate: () =>
    console.log "@grid in adj is "
    for each in @grid.grid
      console.log each
    for i in [@x - 1, @x, @x + 1]
      for j in [@y - 1, @y, @y + 1]
        continue if i is @x and j is @y
        @cells.push @validLocation @grid, i, j
    @cells.list

  # returns a valid location if it exists, otherwise null
  validLocation: (grid,x,y) =>
    while grid.validIndices x, y
      return new Tuple x, y if (@empty grid, x, y)
      y--
    null

  empty: (grid,x,y) =>
    (grid.at x, y) is null

module.exports = AdjacentCellsCalculator
