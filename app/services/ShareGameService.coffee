$ = require 'jquery'
SolutionService = require './SolutionService'

class ShareGameService

  @reloadPageWithHash: (board, solutionPlacements, inputs) ->
    console.log @checkSolutionPlacements board, solutionPlacements, inputs
    hashVal = ''
    for row in board.initialValues
      for col in row
        hashVal += col
    for goal in board.goals
      hashVal += '_' + goal
    window.location.hash = hashVal

  @checkSolutionPlacements: (board, solutionPlacements, inputs) ->
    @tempBoard = {}
    @tempBoard.boardValues = []
    for row, i in board.initialValues
      @tempBoard.boardValues.push []
      for col in row
        @tempBoard.boardValues[i].push col
    @solutionService = new SolutionService @tempBoard, board.goals
    index = 0
    for expression in inputs
      clickedCells = []
      for value in expression
        @tempBoard.boardValues[solutionPlacements[index].row][solutionPlacements[index].col].value = ' '
        clickedCells.push solutionPlacements[index++]
      @pushDownTempBoard()
      @solutionService.initialize clickedCells
      if not @solutionService.isSolution()
        return false
    true


  @pushDownTempBoard: ->
    for row in [@tempBoard.boardValues.length-1..1]
      for col in [@tempBoard.boardValues.length-1..0]
        if @tempBoard.boardValues[row][col].value != ' '
          for up in [row-1..0]
            unless @tempBoard.boardValues[up][col].value != ' '
              @swapCells row, col, up, col
              break

  @swapCells: (r1, c1, r2, c2) ->
    temp = @tempBoard.boardValues[r1][c1]
    @tempBoard.boardValues[r1][c1] = @tempBoard.boardValues[r2][c2]
    @tempBoard.boardValues[r2][c2] = temp

module.exports = ShareGameService
