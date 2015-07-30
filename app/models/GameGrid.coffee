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

  isEmpty: (x, y) => return @grid[y][x].value is ' '

  setEmpty: (x, y) =>
    @set x, y, ' '

module.exports = GameGrid
