InputSolver             = require '../services/InputSolver'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
ClickHandler            = require '../services/ClickHandler'
Tuple                   = require '../models/Tuple'
Board                   = require '../views/Board'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    length = 3
    gridModel = []
    two = @createTwo()
    symbols = @getSymbols two

    for i in [0...length]
      gridModel.push (ExpressionGenerator.generate length).split('')

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
    # 10 -> &times
    # 11 -> +
    # 12 -> &divide
    svgs = $('#assets svg')
    symbols = []
    for s,i in svgs
      symbols.push (two.interpret s)
      symbols[i].visible = false
    two.update()
    symbols

  tests: =>
    # @testExpGen()
    # @testCellDelete()
    # @testInputSolver()
    # @testDFS()

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
