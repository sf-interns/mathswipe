Tuple = require '../models/Tuple'
GridCell = require '../models/GridCell'

class DFS

  @setEquationsOnGrid: (@grid, inputList, @AdjacentCells) ->
    @clearSolutionGrid()
    for i in [0...10000]
      break if @hasFoundSolution inputList
      for row in [0...@grid.dimension]
        for col in [0...@grid.dimension]
          @grid.set row, col, ' '
          @clearSolutionGrid()

  @clearSolutionGrid: ->
    @solutionGrid = []
    for row in [0...@grid.dimension]
      @solutionGrid.push []
      for col in [0...@grid.dimension]
        @solutionGrid[row].push (new GridCell col, row)

  @hasFoundSolution: (inputList) ->
    for i in [0...inputList.length]
      hasPlaced = false
      for index in [0...20]
        unless hasPlaced
          cloneGrid = @cloneSolutionGrid()
          seedX = Math.floor(Math.random() * @grid.dimension)
          seedY = Math.floor(Math.random() * @grid.dimension)
          if @search seedX, seedY, inputList[i]
            hasPlaced = true
          else
            @solutionGrid = cloneGrid
      if hasPlaced
        # TODO call push-up/push-down
        @pushDownSolutionGrid()
      else return false
    true

  @search: (seedX, seedY, input) ->
    return true if input.length is 0

    toVisit = @shuffle AdjacentCells.getAdjacent @solutionGrid, seedX, seedY
    return false if toVisit.length is 0

    curr = toVisit.pop()
    while curr != undefined
      @solutionGrid[curr.y][curr.x].value = input[0]
      unless @search curr.x, curr.y, input.slice(1, input.length)
        @solutionGrid = cloneGrid
        curr = toVisit.pop()
      else return true
    false

  @cloneSolutionGrid: ->
    cloneGrid = []
    for row in [0...@solutionGrid.length]
      cloneGrid.push []
      for col in [0...@solutionGrid.length]
        cloneGrid[row].push (new GridCell @solutionGrid[y][x].y, @solutionGrid[y][x].x)
        cloneGrid[row][col].value = @solutionGrid[y][x].value
    cloneGrid

  @pushDownSolutionGrid: ->
    # TODO

  # Fisher-Yates shuffle
  @shuffle: (array) ->
    m = array.length
    while m
      i = Math.floor(Math.random() * m--)
      t = array[m]
      array[m] = array[i]
      array[i] = t
    array

module.exports = DFS
