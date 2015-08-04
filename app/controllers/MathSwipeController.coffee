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
    @gridModel = new GameGrid(3)

    two = @createTwo()
    symbols = @getSymbols two
    @board = new Board @gridModel, two, Cell, Colors
    @tests()

  createTwo: ->
    game = document.getElementById('game')
    two = new Two(
      fullscreen: false
      autostart: true
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
    @testExpGen()
    @testCellDelete()
    @testInputSolver()
    @testDFS()

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
    inputList = ['111', '222', '333' ]
    DFS.setEquationsOnGrid @gridModel, inputList, AdjacentCellsCalculator
    console.log '\n'
    for each in @gridModel.grid
      line = ''
      for j in each
        line += j.value + '\t'
      console.log line

module.exports = MathSwipeController
