InputSolver  = require './InputSolver'

class SolutionService

  constructor: (@board, goals) ->
    @goals = []
    for g in goals
      @goals.push g

  isSolution: (clickedCells) ->
    return false unless clickedCells? and clickedCells.length >= 3
    solution = @getSolutionString clickedCells
    return false if solution[solution.length - 1] is '+' or
      solution[solution.length - 1] is '-' or
      solution[solution.length - 1] is '*'
    value = InputSolver.compute solution
    return false unless value in @goals
    @goals.splice (@goals.indexOf value), 1
    return true

  getSolutionString: (cells) ->
    solution = ''
    for c in cells
      solution += @board.boardValues[c.row][c.col]
    solution

module.exports = SolutionService
