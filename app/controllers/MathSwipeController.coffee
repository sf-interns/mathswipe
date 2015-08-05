InputSolver             = require '../services/InputSolver'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
ClickHandler            = require '../services/ClickHandler'
Tuple                   = require '../models/Tuple'
Board                   = require '../views/Board'
GoalContainer           = require '../views/GoalContainer'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    length = 3
    gridModel = []
    gameScene = @createGameScene()
    goalsScene = @createGoalsScene()
    solutions = []

    for i in [0...length]
      expression = (ExpressionGenerator.generate length)
      gridModel.push expression.split('')
      solutions.push (InputSolver.compute expression).toString()

    boardSymbols = @getSymbolsFor gameScene
    @board = new Board gridModel, gameScene, Cell, Colors, ClickHandler

    goalsSymbols = @getSymbolsFor goalsScene
    @goalContainer = new GoalContainer goalsScene, solutions, goalsSymbols, Colors

    @tests()

  createGameScene: ->
    gameDom = document.getElementById('game')
    size = Math.min(Math.max($( window ).width(), 310), 500)
    scene = new Two(
      fullscreen: false
      autostart: true
      width: size
      height: size
    ).appendTo(gameDom);
    return scene

  createGoalsScene: ->
    goalsDom = document.getElementById('goals')
    scene = new Two(
      fullscreen: false
      autostart: true
      height: goalsDom.clientWidth
      width: goalsDom.clientWidth
    ).appendTo(goalsDom);
    return scene

  getSymbolsFor: (scene) ->
    svgs = $('#assets svg')
    symbols = []
    for svg, index in svgs
      symbols.push (scene.interpret svg)
      symbols[index].visible = false
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
