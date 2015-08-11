AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
ClickHandler            = require '../services/ClickHandler'
TouchHandler            = require '../services/TouchHandler'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
InputSolver             = require '../services/InputSolver'
ResetButton             = require '../services/ResetButton'
SolutionService         = require '../services/SolutionService'
RandomizedFitLength     = require '../services/RandomizedFitLength'
Tuple                   = require '../models/Tuple'
Board                   = require '../views/Board'
GoalContainer           = require '../views/GoalContainer'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    @gameScene = @createGameScene()
    @goalsScene = @createGoalsScene()
    @initialize()
    @createNewGame()
    if @isMobile().any()
      console.log 'MOBILE'
    else
      console.log 'DESKTOP'
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

    for i in inputs
      console.log i
    console.log '\n'

    goalsSymbols = @getSymbolsFor @goalsScene
    @goalContainer = new GoalContainer @goalsScene, answers, goalsSymbols, Colors

    boardSymbols = @getSymbolsFor @gameScene
    gameModel = @generateBoard inputs, length
    handler = if @isMobile().any() then TouchHandler else ClickHandler
    @board = new Board gameModel, @gameScene, Cell, Colors, handler, SolutionService, answers, boardSymbols, @goalContainer
    ResetButton.bindClick @board

  createNewGame: ->
    $('#new-game-button').click (e) =>
      @gameScene.clear()
      @goalsScene.clear()
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
    scene = new Two(
      fullscreen: false
      autostart: true
      height: 100
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

  randExpression: (length) ->
    ExpressionGenerator.generate length

  generateInputs: (length) ->
    inputs = []
    inputs.push @randExpression(length).split('') for i in [0...length]
    inputs

  generateBoard: (inputs, length) ->
    DFS.setEquationsOnGrid length, inputs, AdjacentCellsCalculator

  isMobile: ()->
    {
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
    }

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
