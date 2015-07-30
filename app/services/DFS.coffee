Tuple    = require '../models/Tuple'
TupleSet = require '../models/TupleSet'

class DFS

  @isValidSeed: (x, y) ->
    return false if x - 1 < 0 or x + 1 >= @grid.dimension
    emptyInCol = []
    for col in [x - 1, x, x + 1]
      numEmpty = 0
      for row in [0...@grid.dimension]
        numEmpty += 1 if @grid.grid[row][col] is ' '
      emptyInCol.push numEmpty
    return (emptyInCol[0] > 0 and emptyInCol[1] is 1 and emptyInCol[2] > 0)

  # Fisher-Yates shuffle
  @shuffle: (array) ->
    m = array.length
    while m
      i = Math.floor(Math.random() * m--)
      t = array[m]
      array[m] = array[i]
      array[i] = t
    array

  @search: (seed, input, takenCells) ->
    return true if input.length is 0

    calculator = new @AdjacentCells @grid, null, seed.x, seed.y
    toVisit = @shuffle calculator.getToVisit takenCells.list
    return false if toVisit.length is 0
    curr = toVisit.pop()
    return false if @isValidSeed curr.x, curr.y

    while curr != undefined
      @grid.set curr.x, curr.y, input[0]
      takenCells.push new Tuple curr.x, curr.y
      hasSolution = @search curr, input.slice(1, input.length), takenCells
      return true if hasSolution
      @grid.set curr.x, curr.y, ' '
      takenCells.pop()
      curr = toVisit.pop()
    false

  @initializeGrid: (allCells, inputList) ->
    for i in [0...inputList.length]
      for index in [0...20]
        seed = allCells[Math.floor(Math.random() * allCells.length)]
        break if @search seed, inputList[i], (new TupleSet)
        return false
    true

  @setEquationsOnGrid: (@grid, inputList, @AdjacentCells) ->
    allCells = []
    for i in [0...@grid.dimension]
      for j in [0...@grid.dimension]
        allCells.push new Tuple i, j

    for i in [0...1000]
      break if @initializeGrid allCells, inputList
      for row in [0...@grid.dimension]
        for col in [0...@grid.dimension]
          @grid.set row, col, ' '
    true

module.exports = DFS
