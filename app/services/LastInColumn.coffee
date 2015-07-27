GameGrid = require ("../models/GameGrid")

class LastInColumn
  isLastAndBlocking: (grid) ->
    colCount = []
    for col in [0..grid.length - 1]
      count = 0
      for row in [0..grid.length - 1]
        if grid[row][col] is null
          count += 1
      colCount.push count
    for index in [1..colCount.length-2]
      if colCount[index] is 1 and colCount[index-1] > 0 and colCount[index+1] > 0
        return true
    false

module.exports = LastInColumn
