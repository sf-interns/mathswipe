class GameGrid
  @grid = []

  constructor: (size) ->
    for i in [0..size]
      @grid.push []

  add: (x, y, element) ->
    @grid[y][x] = element

  atIndex: (x,y) ->
    return grid[y][x]

module.exports = GameGrid
