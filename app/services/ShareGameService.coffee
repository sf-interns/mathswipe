$ = require 'jquery'
SolutionService = require './SolutionService'

# btoa('{"a":"9677*1+8*","b":[135,102],"c":[[2,2,1,1,0],[7,8,9,4]]}');
# "eyJhIjoiOTY3NyoxKzgqIiwiYiI6WzEzNSwxMDJdLCJjIjpbWzIsMiwxLDEsMF0sWzcsOCw5LDRdXX0="

class ShareGameService

  @reloadPageWithHash: (board, solutionPlacements) ->
    console.log @checkSolutionPlacements board, solutionPlacements
    hash = @encode board.initialValues, board.goals, solutionPlacements
    window.location.hash = hash

  @encode: (boardValues, goals, slnPlacements) ->
    boardValues = (JSON.stringify boardValues).replace(/(\[|\]|"|,|{|})*/g, '')

    length = Math.sqrt boardValues.length
    for placement in [0...slnPlacements.length]
      for coord in [0...slnPlacements[placement].length]
        slnPlacements[placement][coord] = slnPlacements[placement][coord][0] * length + slnPlacements[placement][coord][1]

    btoa(JSON.stringify {b: boardValues, g: goals, p: slnPlacements})

  @decode: (boardValues, goals, slnPlacements) ->
    decoded = JSON.parse atob window.location.hash.substr(1, window.location.hash.length)
    length = Math.sqrt decoded.b.length
    index = 0

    for i in [0...length]
      row = []
      for j in [0...length]
        row.push decoded.b[index++]
      boardValues.push row

    goals = decoded.g

    console.log decoded.p

  @checkSolutionPlacements: (board, solutionPlacements) ->
    @tempBoard = {}
    @tempBoard.boardValues = []
    for row, i in board.initialValues
      @tempBoard.boardValues.push []
      for col in row
        @tempBoard.boardValues[i].push col
    @solutionService = new SolutionService @tempBoard, board.goals
    for expression in solutionPlacements
      clickedCells = []
      for index in [0...expression.length]
        cell = expression[index]
        clickedCells.push {row: cell[0], col: cell[1]}
      @solutionService.initialize clickedCells
      for cell in clickedCells
        @tempBoard.boardValues[cell.row][cell.col] = ' '
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
