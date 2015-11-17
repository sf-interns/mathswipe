class HashingService

  alphabet = ['"', '{', '}', '[', ']', ',', ':',
              'b', 'g', 'p', '1', '2', '3', '4',
              '5', '6', '7', '8', '9', '0',
              '+', '-', '*']

  @reloadPageWithHash: (board, solutionPlacements, SolutionService) ->
    unless @checkSolutionPlacements board, solutionPlacements, SolutionService
      @emptyHash()
      return false
    HashingService.setHash board.initialValues, board.goals, solutionPlacements

  @emptyHash: -> window.location.hash = ''

  @setHash: (boardValues, goals, solutionPlacements) ->
    window.location.hash = @encode boardValues, goals, solutionPlacements

  @encode: (boardValues, goals, solutionPlacements) ->
    boardValues = (JSON.stringify boardValues).replace(/(\[|\]|"|,|{|})*/g, '')

    length = Math.sqrt boardValues.length
    for list in [0...solutionPlacements.length]
      for pos in [0...solutionPlacements[list].length]
        solutionPlacements[list][pos] =
          solutionPlacements[list][pos][0] * length +
            solutionPlacements[list][pos][1]

    btoa(JSON.stringify {b: boardValues, g: goals, p: solutionPlacements})

  @decodeMap: ->
    try
      decoded_s  = atob window.location.hash.substr(1, window.location.hash.length)
      decoded = JSON.parse decoded_s
    catch e
      decoded = null
    return decoded

  @parse: (decoded) ->
    return [[],[],[]] unless @successfulDecode decoded
    length = Math.sqrt decoded.b.length
    b = @decodeBoardValues decoded.b, length
    g = @decodeGoals decoded.g
    p = @decodeSolutionPlacements decoded.p, length
    [b, g, p]

  @successfulDecode: (decoded)->
    return decoded? and
           decoded.p? and
           decoded.g? and
           decoded.p? and
           @regexPass decoded

  @regexPass: (decoded) ->
    for char in decoded
      return false if char not in alphabet
    true

  @decodeBoardValues: (copy, length, boardValues=[] ) ->
    index = 0
    for i in [0...length]
      row = []
      for j in [0...length]
        row.push copy[index++]
      boardValues.push row
    boardValues

  @decodeGoals: (toCopy) -> toCopy[..]

  @decodeSolutionPlacements: (copy, length, solutionPlacements=[]) ->
    for list in [0...copy.length]
      expression = []
      for coord in [0...copy[list].length]
        expression.push [(Math.floor copy[list][coord] / length),
                         (copy[list][coord] % length)]
      solutionPlacements.push expression
    solutionPlacements

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

      return false unless @solutionService.isSolution()
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

module.exports = HashingService
