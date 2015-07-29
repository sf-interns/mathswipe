Tuple    = require '../models/Tuple'
TupleSet = require '../models/TupleSet'

class AdjacentCellsCalculator

  # Param grid is a GameGrid
  constructor: (@grid, @cells=(new TupleSet), @x, @y) ->

  # Gets the adjacent cells
  getToVisit: (takenCells) =>
    for i in [@x - 1, @x, @x + 1]
      for j in [@y - 1, @y, @y + 1]
        unless @occupied(i, j, takenCells) or (i is @x and j is @y)
          tuple = @validLocation @grid, i, j
          @cells.push tuple
    @cells.list

  # returns a valid location if it exists, otherwise null
  validLocation: (grid, x, y) =>
    while grid.validIndices x, y
      return new Tuple x, y if (@empty grid, x, y)
      y--
    null

  empty: (grid,x,y) => (grid.at x, y) is ' '

  occupied: (x, y, takenCells) =>
    for cell in takenCells
      if x is cell.x and y is cell.y
        return true
    false

module.exports = AdjacentCellsCalculator
