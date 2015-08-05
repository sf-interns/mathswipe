InputSolver             = require '../services/InputSolver'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
ClickHandler            = require '../services/ClickHandler'
RandomizedFitLength     = require '../services/RandomizedFitLength'
Tuple                   = require '../models/Tuple'
Board                   = require '../views/Board'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    length = 3
    two = @createTwo()
    symbols = @getSymbols two
    gridModel = @generateBoard length
    @board = new Board gridModel, two, Cell, Colors, ClickHandler, symbols

    @tests()

  createTwo: ->
    game = document.getElementById('game')
    size = Math.min(Math.max($( window ).width(), 310), 500)
    two = new Two(
      fullscreen: false
      autostart: true
      width: size
      height: size
    ).appendTo(game);
    return two

  getSymbols: (two) ->
    # note symbols 0-9 are numbers 0-9.
    # 10 -> +
    # 11 -> minus
    # 12 -> &times
    svgs = $('#assets svg')
    symbols = []
    for s,i in svgs
      symbols.push (two.interpret s)
      symbols[i].visible = false
    two.update()
    symbols

  randExpression: (length) ->
    ExpressionGenerator.generate length

  generateBoard: (length) ->
    inputs = []
    inputs.push @randExpression(length).split('') for i in [0...length]
    for input in inputs
      console.log input
      console.log InputSolver.compute input.join('')
    DFS.setEquationsOnGrid length, inputs, AdjacentCellsCalculator

  tests: =>
    @testRandomizedFitLength()
    @testExpGen()
    @testCellDelete()
    @testInputSolver()
    @testDFS()

  testRandomizedFitLength: =>
    size = 25
    for i in [0...100]
      list = RandomizedFitLength.generate size
      sum = 0
      for j in list
        sum += j
      if sum != size
        console.log "Something went wrong with RandomizedFitLength"
        console.log list
        break
    console.log list
    console.log "Passed RandomizedFitLength"

  testExpGen: =>
    for length in [1..30]
      expression = ExpressionGenerator.generate length
      console.log length, expression, InputSolver.compute expression

  testCellDelete: =>
    solution = [(new Tuple 0, 0), (new Tuple 1, 1), (new Tuple 0, 2)]
    @board.deleteCells solution

  testInputSolver: =>
    console.log InputSolver.compute('1+2*3')

  testDFS: =>
    length = 5
    inputList = []

    for i in [0...length]
      inputList.push (ExpressionGenerator.generate length).split('')
    for each in inputList
      console.log each

    console.log '\n'
    for each in DFS.setEquationsOnGrid length, inputList, AdjacentCellsCalculator
      line = ''
      for j in each
        line += j + '\t'
      console.log line

module.exports = MathSwipeController
