AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
BoardSolvedService      = require '../services/BoardSolvedService'
ClickHandler            = require '../services/ClickHandler'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
InputSolver             = require '../services/InputSolver'
RandomizedFitLength     = require '../services/RandomizedFitLength'
ResetButton             = require '../services/ResetButton'
RunningSum              = require '../services/RunningSum'
SolutionService         = require '../services/SolutionService'
Tuple                   = require '../models/Tuple'
Board                   = require '../views/Board'
GoalContainer           = require '../views/GoalContainer'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    @gameScene = @createGameScene()
    @goalsScene = $('#goals')
    @symbols = @getSymbols()
    @initialize()
    @bindNewGameButton()
    # @tests()

  initialize: ->
    length = 3
    inputs = []
    answers = []

    inputLengths = RandomizedFitLength.generate length * length
    for inputSize in inputLengths
      expression = (ExpressionGenerator.generate inputSize)
      inputs.push expression.split('')
      answers.push (InputSolver.compute expression)

    console.log i for i in inputs
    console.log '\n'

    gameModel = @generateBoard inputs, length
    @goalContainer = new GoalContainer @goalsScene, answers, @symbols, Colors
    @board = new Board gameModel, @gameScene, answers, @symbols, @goalContainer, @isMobile().any()?, Cell, Colors, ClickHandler, SolutionService, BoardSolvedService, RunningSum
    ResetButton.bindClick @board

  bindNewGameButton: ->
    $('#new-game-button').click (e) =>
      @gameScene.clear()
      @goalContainer.clearGoals()
      ResetButton.unbindClick()
      @initialize()

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

  getSymbols: ->
    scene = new Two()
    svgs = $('#assets svg')
    symbols = []
    for svg, index in svgs
      symbols.push (scene.interpret svg)
      symbols[index].visible = false
    symbols

  randExpression: (length) ->
    ExpressionGenerator.generate length

  generateInputs: (length) ->
    inputs = []
    inputs.push @randExpression(length).split('') for i in [0...length]
    inputs

  generateBoard: (inputs, length) ->
    DFS.setEquationsOnGrid length, inputs, AdjacentCellsCalculator

  isMobile: () ->
    Android: () ->
      return navigator.userAgent.match(/Android/i)
    BlackBerry: () ->
      return navigator.userAgent.match(/BlackBerry/i)
    iOS: ()->
      return navigator.userAgent.match(/iPhone|iPad|iPod/i)
    Opera: () ->
      return navigator.userAgent.match(/Opera Mini/i)
    Windows: () ->
      return navigator.userAgent.match(/IEMobile/i)
    any: () ->
      return (@Android() || @BlackBerry() || @iOS() || @Opera() || @Windows())

  tests: =>
    @testRandomizedFitLength()
    @testExpGen()
    # @testCellDelete()
    @testInputSolver()
    @testDFS()

  testRandomizedFitLength: =>
    size = 25
    list = RandomizedFitLength.generate size
    console.log list
    console.log 'Passed RandomizedFitLength'

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
