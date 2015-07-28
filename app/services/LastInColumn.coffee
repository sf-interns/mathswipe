GameGrid = require ("../models/GameGrid")

class LastInColumn

  isLastAndBlocking: (grid, x, y) ->
    if x - 1 < 0 or x + 1 >= grid.dimension
      return false
    colCount = []
    for col in [x - 1, x, x + 1]
      count = 0
      for row in [0..grid.dimension]
        if grid[row][col] is null
          count += 1
      colCount.push count
    if colCount[1] is 1 and colCount[0] > 0 and colCount[2] > 0
      return true
    false

module.exports = LastInColumn
