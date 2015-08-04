GridCell = require './GridCell'

class GameGrid

  constructor: (@dimension) ->
    @grid = []
    for row in [0...@dimension]
      @grid.push []
      for col in [0...@dimension]
        @grid[row].push (new GridCell col, row)

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

  setEmpty: (x, y) => @set x, y, ' '

module.exports = GameGrid
