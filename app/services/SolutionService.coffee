InputSolver = require './InputSolver'

class SolutionService

  constructor: (@board, goals, @RunningSum) ->
    @goals = []
    @goals.push g for g in goals

  initialize: (clickedCells) ->
    @setSolutionString clickedCells
    @value = InputSolver.compute @solution

  isSolution: ->
    return false unless @solution? and @finished and @value in @goals
    if @isCompleteExpression()
      @valueIndex = @goals.indexOf @value
      @goals[@valueIndex] = ' '
      true
    else
      @RunningSum.display @RunningSum.solutionOperatorString
      false

  finished: ->
    @solution[@solution.length - 1] not in "+-*" and
      @solution[0] not in "+-*"

  isCompleteExpression: -> @solution.search(/-?\d+[-+\*]\d+/g) is 0

  setSolutionString: (cells) ->
    @solution = ''
    for c in cells
      @solution += @board.boardValues[c.row][c.col]

module.exports = SolutionService
