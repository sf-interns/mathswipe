InputSolver             = require '../services/InputSolver'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
Tuple                   = require '../models/Tuple'
GameGrid                = require '../models/GameGrid'
Board                   = require '../views/Board'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    @gridModel = new GameGrid(4)

    two = @createTwo()
    symbols = @getSymbols two
    @board = new Board @gridModel, two, Cell, Colors

    @tests()

  createTwo: ->
    two = new Two(
      fullscreen: true
      autostart: true
    ).appendTo(document.getElementById('game'));
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
    @testExpGen()
    @testDFS()
    @testCellDelete()
    @testInputSolver()

  testExpGen: =>
    for length in [1..30]
      expression = ExpressionGenerator.generate length
      console.log length, expression, InputSolver.compute expression

  testCellDelete: =>
    solution = [(new Tuple 0, 3), (new Tuple 0, 2), (new Tuple 1, 1)]
    soln = [(new Tuple 3, 3), (new Tuple 2, 3), (new Tuple 0, 3)]
    @board.deleteCells solution
    @board.deleteCells soln

  testInputSolver: =>
    console.log InputSolver.compute('1+2*3')

  testDFS: =>
    inputList = ['1111', '2222', '3333', '4444' ]
    DFS.setEquationsOnGrid @gridModel, inputList, AdjacentCellsCalculator


module.exports = MathSwipeController
