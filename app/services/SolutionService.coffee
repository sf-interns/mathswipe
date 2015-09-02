InputSolver = require './InputSolver'

class SolutionService

  constructor: (@board, goals, @RunningSum) ->
    @goals = []
    @goals.push g for g in goals

  initialize: (clickedCells) ->
    @setSolutionString clickedCells
    @value = InputSolver.compute @solution

  isSolution: ->
    return false unless @solution?
    return false if @solution[@solution.length - 1] is '+' or
      @solution[@solution.length - 1] is '-' or
      @solution[@solution.length - 1] is '*'
    return false unless @value in @goals
    if not @isCompleteExpression()
      @RunningSum.display @RunningSum.solutionOperatorString
      return false
    @valueIndex = @goals.indexOf @value
    @goals[@valueIndex] = ' '
    true

  isCompleteExpression: -> @solution.search(/-?\d+[-+\*]\d+/g) is 0

  setSolutionString: (cells) ->
    @solution = ''
    for c in cells
      @solution += @board.boardValues[c.row][c.col]

module.exports = SolutionService
