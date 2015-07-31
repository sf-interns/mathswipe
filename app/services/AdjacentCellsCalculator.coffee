Tuple    = require '../models/Tuple'

class AdjacentCellsCalculator

  # Param grid is a GameGrid
  constructor: (@grid, @x, @y) -> @cells = []

  # Gets valid placements in grid
  getToVisit: (takenCells) =>
    for i in [@x - 1, @x, @x + 1]
      for j in [@y - 1, @y, @y + 1]
        unless @isOccupied(i, j, takenCells) or (i is @x and j is @y)
          tuple = @validLocation @grid, i, j
          @cells.push tuple unless tuple is null
    @cells

  # returns a valid location if it exists, otherwise null
  validLocation: (grid, x, y) =>
    while grid.validIndices x, y
      return (new Tuple x, y) if (@grid.isEmpty x, y)
      y--
    null

  isOccupied: (x, y, takenCells) =>
    for cell in takenCells
      return true if x is cell.x and y is cell.y
    false

module.exports = AdjacentCellsCalculator
