InputSolver         = require '../services/InputSolver'
GameGrid            = require '../models/GameGrid'
ExpressionGenerator = require '../services/ExpressionGenerator'
Board               = require '../views/Board'
Tuple               = require '../models/Tuple'
$                   = require 'jQuery'

class MathSwipeController 

  constructor: ->
    console.log InputSolver.compute("1+2*3")
    gridModel = new GameGrid(4)

    two = @createTwo()
    symbols = @getSymbols two
    @board = new Board gridModel, two
    two.update()

    @tests()

  createTwo: -> 
    two = new Two(
      fullscreen: true
      autostart: true
      # width: 700
      # height: 700
    ).appendTo(document.getElementById('game'));
    return two

  getSymbols: (two)->
    # note symbols 0-9 are numbers 0-9.
    # 10 -> &times
    # 11 -> +
    # 12 -> &divide
    svgs = $('#assets svg')
    symbols = []
    for s,i in svgs
      symbols.push (two.interpret s)
      symbols[i].visible = false
    symbols

  tests: =>
    @testExpGen()
    @testCellDelete()

  testExpGen: =>
    for length in [1..30]
      expression = ExpressionGenerator.generate length
      console.log length, expression, InputSolver.compute expression

  testCellDelete: =>
    solution = [(new Tuple 1, 1), (new Tuple 2, 2), (new Tuple 3, 3)]
    @board.deleteCells solution

module.exports = MathSwipeController
