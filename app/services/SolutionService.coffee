InputSolver  = require './InputSolver'

class SolutionService

  constructor: (@board, @goals) ->
    console.log 'HELLO!!!'
    console.log @goals

  isSolution: (clickedCells) ->
    return false unless clickedCells? and clickedCells.length > 0
    solution = ''
    for cell in clickedCells
      solution += @board.boardValues[cell.row][cell.col]
    console.log solution, @goals
    InputSolver.compute(solution) in @goals

module.exports = SolutionService
