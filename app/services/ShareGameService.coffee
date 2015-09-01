$ = require 'jquery'
SolutionService = require './SolutionService'

class ShareGameService

  @reloadPageWithHash: (board, solutionPlacements, inputLengths) ->
    console.log @checkSolutionPlacements board, solutionPlacements, inputLengths
    hashVal = ''
    for row in board.initialValues
      for col in row
        hashVal += col
    for goal in board.goals
      hashVal += '_' + goal
    hashVal += '_'
    for placementList in solutionPlacements
      for expression in placementList
        hashVal += '&' + expression[0] + ',' + expression[1]
    window.location.hash = hashVal

  @checkSolutionPlacements: (board, solutionPlacements, inputLengths) ->
    @tempBoard = {}
    @tempBoard.boardValues = []
    for row, i in board.initialValues
      @tempBoard.boardValues.push []
      for col in row
        @tempBoard.boardValues[i].push col
    @solutionService = new SolutionService @tempBoard, board.goals
    index = 0
    console.log inputLengths
    for expression in inputLengths
      clickedCells = []
      temp = index
      for value in [0...expression.length]
        cell = solutionPlacements[index++]
        clickedCells.push {row: cell[0], col: cell[1]}
      @solutionService.initialize clickedCells
      for temp in [temp...index]
        @tempBoard.boardValues[solutionPlacements[temp].row][solutionPlacements[temp].col] = ' '
      @pushDownTempBoard()

      unless @solutionService.isSolution()
        return false
    true

  @pushDownTempBoard: ->
    for row in [@tempBoard.boardValues.length-1..1]
      for col in [@tempBoard.boardValues.length-1..0]
        if @tempBoard.boardValues[row][col] is ' '
          for up in [row-1..0]
            unless @tempBoard.boardValues[up][col] is ' '
              @swapCells row, col, up, col
              break

  @swapCells: (r1, c1, r2, c2) ->
    temp = @tempBoard.boardValues[r1][c1]
    @tempBoard.boardValues[r1][c1] = @tempBoard.boardValues[r2][c2]
    @tempBoard.boardValues[r2][c2] = temp

module.exports = ShareGameService
