GridCell = require './GridCell'

class GameGrid

  constructor: (dimension) ->
    @grid = []
    @dimension = dimension
    for i in [0...@dimension]
      @grid.push []
      for j in [0...@dimension]
        @grid[i].push (new GridCell)

  set: (x, y, element) =>
    return false unless @validIndices x, y
    @grid[y][x].value = element
    true

  validIndices: (x, y) =>
    return x < @dimension and x >= 0 and y < @dimension and y >= 0

  at: (x, y) =>
    return null unless @validIndices x, y
    @grid[y][x]

  isEmpty: (x, y) => @grid[y][x].isEmpty()

  delete: (x, y) =>
    @grid[y][x].delete()

  swapCells: (r1, c1, r2, c2) =>
    temp = @grid[r1][c1]
    @grid[r1][c1] = @grid[r2][c2]
    @grid[r2][c2] = temp

module.exports = GameGrid
