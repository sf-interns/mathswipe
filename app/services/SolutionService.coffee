InputSolver  = require './InputSolver'

class SolutionService

  constructor: (@board, goals) ->
    @goals = []
    for g in goals
      @goals.push g

  isSolution: (clickedCells) ->
    return false unless clickedCells? and clickedCells.length > 0
    solution = ''
    for cell in clickedCells
      solution += @board.boardValues[cell.row][cell.col]
    soln = InputSolver.compute(solution)
    console.log soln in @goals, solution.length
    return false unless soln in @goals and solution.length >= 3
    @goals.splice (@goals.indexOf soln), 1
    return true

module.exports = SolutionService
