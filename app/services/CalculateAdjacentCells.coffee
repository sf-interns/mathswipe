Tuple = require "../models/Tuple"

class CalculateAdjacentCells

  # Param grid is a GameGrid
  constructor: (@grid, @cells, @x, @y) ->
    for i in [@y - 1, @y, @y + 1]
      for j in [@x - 1, @x, @x + 1]
        if i is @y and j is @x then continue
        @cells.push @validLocation @grid, i, j

  # Gets the adjacent cells
  get: () =>
    @cells

  validLocation: (grid,x,y) =>
    loc = grid.at x,y

    if loc is null
      return new Tuple x, y
    else if loc is false 
      null
    else #go up
      @checkAbove x, y

  checkAbove: (x,y) =>
    @validLocation x, y - 1

module.exports = CalculateAdjacentCells
