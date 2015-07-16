class GameGrid

  constructor: (dimension) ->
    @grid = []
    @dimension = dimension
    for i in [0..@dimension-1]
      @grid.push []
      for j in [0..@dimension-1]
        @grid[i].push ''

  set: (x, y, element) ->
    return false unless @validIndices x, y
    @grid[y][x] = element
    true

  validIndices: (x,y) ->
    return x < @dimension and x >= 0 and y < @dimension and y >= 0  

  at: (x,y) ->
    grid[y][x]

module.exports = GameGrid
