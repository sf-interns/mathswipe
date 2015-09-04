$ = require 'jquery'

class ShareGameService

  @reloadPageWithHash: (board, solutionPlacements, SolutionService) ->
    unless @checkSolutionPlacements board, solutionPlacements, SolutionService
      window.location.hash = ''
      return false
    hash = @encode board.initialValues, board.goals, solutionPlacements
    window.location.hash = hash

  @encode: (boardValues, goals, solutionPlacements) ->
    boardValues = (JSON.stringify boardValues).replace(/(\[|\]|"|,|{|})*/g, '')

    length = Math.sqrt boardValues.length
    for list in [0...solutionPlacements.length]
      for pos in [0...solutionPlacements[list].length]
        solutionPlacements[list][pos] = solutionPlacements[list][pos][0] * length +
                                               solutionPlacements[list][pos][1]

    btoa(JSON.stringify {b: boardValues, g: goals, p: solutionPlacements})

  @decode: (boardValues, goals, solutionPlacements) ->
    try
      decoded = atob window.location.hash.substr(1, window.location.hash.length)
      decoded = JSON.parse decoded
    catch e
      decoded = null
    return false unless decoded? and decoded.b? and decoded.g? and
                        decoded.p? and @isValidDecode decoded

    length = Math.sqrt decoded.b.length
    @decodeBoardValues decoded.b, boardValues, length
    @decodeGoals decoded.g, goals
    @decodeSolutionPlacements decoded.p, solutionPlacements, length
    true

  @isValidDecode: (decoded) ->
    alphabet = ['"', '{', '}', '[', ']', ',', ':',
                'b', 'g', 'p', '1', '2', '3', '4',
                '5', '6', '7', '8', '9', '0',
                '+', '-', '*']
    for char in decoded
      return false if alphabet.indexOf(char) is -1
    true

  @decodeBoardValues: (copy, boardValues, length) ->
    index = 0
    for i in [0...length]
      row = []
      for j in [0...length]
        row.push copy[index++]
      boardValues.push row

  @decodeGoals: (copy, goals) ->
    goals.push goal for goal in copy

  @decodeSolutionPlacements: (copy, solutionPlacements, length) ->
    for list in [0...copy.length]
      expression = []
      for coord in [0...copy[list].length]
        expression.push [(Math.floor copy[list][coord] / length),
                         (copy[list][coord] % length)]
      solutionPlacements.push expression

  @checkSolutionPlacements: (board, solutionPlacements, SolutionService) ->
    @initializeTempBoard board
    @solutionService = new SolutionService @tempBoard, board.goals

    inputs = []
    for expression in solutionPlacements
      clickedCells = []
      for index in [0...expression.length]
        cell = expression[index]
        clickedCells.push {row: cell[0], col: cell[1]}
      @solutionService.initialize clickedCells

      solution = []
      for cell in clickedCells
        solution.push @tempBoard.boardValues[cell.row][cell.col]
        @tempBoard.boardValues[cell.row][cell.col] = ' '
      @pushDownTempBoard()

      unless @solutionService.isSolution()
        return false
      inputs.push solution

    console.log expression for expression in inputs
    console.log '\n'
    true

  @initializeTempBoard: (board) ->
    @tempBoard = {}
    @tempBoard.boardValues = []
    for row, i in board.initialValues
      @tempBoard.boardValues.push []
      for col in row
        @tempBoard.boardValues[i].push col

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

  @setMessage: ->
    possible = ['Play MathSwipe with me! Try to beat my score at',
                'Play MathSwipe with me! Try to solve my board at',
                'Play MathSwipe with me! Solve my puzzle at']
    text = possible[Math.floor(Math.random() * 3)]
    $( '#tweet' ).attr( 'data-text' , text )

module.exports = ShareGameService
