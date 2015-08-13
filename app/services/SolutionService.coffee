InputSolver = require './InputSolver'

class SolutionService

  constructor: (@board, goals) ->
    @goals = []
    for g in goals
      @goals.push g

  initialize: (clickedCells) ->
    @setSolutionString clickedCells
    @value = InputSolver.compute @solution

  isSolution: ->
    return false unless @solution?.length >= 3
    return false if @solution[@solution.length - 1] is '+' or
      @solution[@solution.length - 1] is '-' or
      @solution[@solution.length - 1] is '*'
    return false unless @value in @goals
    @valueIndex = @goals.indexOf @value
    @goals[@valueIndex] = ' '
    return true

  setSolutionString: (cells) ->
    @solution = ''
    for c in cells
      @solution += @board.boardValues[c.row][c.col]

module.exports = SolutionService
