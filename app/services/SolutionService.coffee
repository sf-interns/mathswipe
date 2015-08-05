InputSolver  = require './InputSolver'

class SolutionService

  constructor: (@board, goals) ->
    @goals = []
    for g in goals
      @goals.push g

  isSolution: (clickedCells) ->
    return false unless clickedCells? and clickedCells.length > 0
    solution = @getSolutionString clickedCells
    value = InputSolver.compute solution
    return false unless value in @goals and solution.length >= 3
    @goals.splice (@goals.indexOf value), 1
    return true

  getSolutionString: (cells) ->
    solution = ''
    for c in cells
      solution += @board.boardValues[c.row][c.col]
    solution

module.exports = SolutionService
