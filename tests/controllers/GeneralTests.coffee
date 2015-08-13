AdjacentCellsCalculator = require '../../app/services/AdjacentCellsCalculator'
DFS                     = require '../../app/services/DFS'
ExpressionGenerator     = require '../../app/services/ExpressionGenerator'
InputSolver             = require '../../app/services/InputSolver'
RandomizedFitLength     = require '../../app/services/RandomizedFitLength'
Tuple                   = require '../../app/models/Tuple'

class GeneralTests

  @tests: (board) ->
    @testRandomizedFitLength()
    @testExpGen()
    @testCellDelete(board)
    @testInputSolver()
    @testDFS()

  @testRandomizedFitLength: ->
    console.log 'Testing RandomizedFitLength'
    size = 25
    list = RandomizedFitLength.generate size
    console.log list
    console.log 'Passed RandomizedFitLength\n\n'

  @testExpGen: ->
    console.log 'Testing ExpressionGenerator'
    for length in [1..10]
      expression = ExpressionGenerator.generate length
      console.log length, expression, InputSolver.compute expression
    console.log 'Passed ExpressionGenerator\n\n'

  @testCellDelete: (board) ->
    console.log 'Testing Cell Delete'
    solution = [(new Tuple 0, 0), (new Tuple 1, 1), (new Tuple 0, 2)]
    board.deleteCells solution
    console.log 'Passed Cell Delete\n\n'

  @testInputSolver: ->
    console.log 'Testing Input Solver'
    console.log '1+2*3 =', InputSolver.compute('1+2*3')
    console.log 'Passed Input Solver\n\n'

  @testDFS: ->
    console.log 'Testing DFS'
    length = 5
    inputList = []

    for i in [0...length]
      inputList.push (ExpressionGenerator.generate length).split('')
    console.log 'Expressions are:'
    for expression in inputList
      console.log expression

    console.log '\n'
    for row in DFS.setEquationsOnGrid length, inputList, AdjacentCellsCalculator
      line = ''
      for char in row
        line += char + '\t'
      console.log line
    console.log 'Passed DFS\n\n'

module.exports = GeneralTests
