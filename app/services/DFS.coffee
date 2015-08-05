Tuple = require '../models/Tuple'
GridCell = require '../models/GridCell'

class DFS

  @setEquationsOnGrid: (@size, inputList, @AdjacentCells) ->
    @clearSolutionGrid()
    grid = @createEmptyGrid()
    for i in [0...10000]
      if @hasFoundSolution inputList
        for row in [0...@solutionGrid.length]
          for col in [0...@solutionGrid.length]
            grid[@solutionGrid[row][col].y][@solutionGrid[row][col].x] = @solutionGrid[row][col].value
        return grid
      @clearSolutionGrid()
    null

  @clearSolutionGrid: ->
    @solutionGrid = []
    for row in [0...@size]
      @solutionGrid.push []
      for col in [0...@size]
        @solutionGrid[row].push (new GridCell col, row)

  @hasFoundSolution: (inputList) ->
    for i in [0...inputList.length]
      hasPlaced = false
      for index in [0...20]
        unless hasPlaced
          cloneGrid = @cloneSolutionGrid()
          seedX = Math.floor(Math.random() * @size)
          seedY = Math.floor(Math.random() * @size)
          if @search seedX, seedY, inputList[i]
            hasPlaced = true
          else
            @solutionGrid = cloneGrid
      if hasPlaced
        @pushDownSolutionGrid()
      else return false
    true

  @search: (seedX, seedY, input) ->
    return true if input.length is 0

    toVisit = @shuffle @AdjacentCells.getAdjacent @solutionGrid, seedX, seedY
    return false if toVisit.length is 0

    curr = toVisit.pop()
    while curr != undefined
      @solutionGrid[curr.y][curr.x].value = input[0]
      unless @search curr.x, curr.y, input.slice(1, input.length)
        @solutionGrid[curr.y][curr.x].value = ' '
        curr = toVisit.pop()
      else return true
    false

  @cloneSolutionGrid: ->
    cloneGrid = []
    for row in [0...@solutionGrid.length]
      cloneGrid.push []
      for col in [0...@solutionGrid.length]
        cloneGrid[row].push (new GridCell @solutionGrid[row][col].x, @solutionGrid[row][col].y)
        cloneGrid[row][col].value = @solutionGrid[row][col].value
    cloneGrid

  @pushDownSolutionGrid: ->
    for row in [@solutionGrid.length-1..1]
      for col in [@solutionGrid.length-1..0]
        if @solutionGrid[row][col].value != ' '
          for up in [row-1..0]
            unless @solutionGrid[up][col].value != ' '
              @swapCells row, col, up, col
              break

  @swapCells: (r1, c1, r2, c2) ->
    temp = @solutionGrid[r1][c1]
    @solutionGrid[r1][c1] = @solutionGrid[r2][c2]
    @solutionGrid[r2][c2] = temp

  @createEmptyGrid: ->
    grid = []
    for row in [0...@size]
      grid.push []
      for col in [0...@size]
        grid[row].push ' '
    grid

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
