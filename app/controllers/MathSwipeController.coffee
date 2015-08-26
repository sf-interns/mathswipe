$                       = require 'jquery'
AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
BoardSolvedService      = require '../services/BoardSolvedService'
ClickHandler            = require '../services/ClickHandler'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
HowToPlay               = require '../services/HowToPlay'
InputSolver             = require '../services/InputSolver'
RandomizedFitLength     = require '../services/RandomizedFitLength'
ResetButton             = require '../services/ResetButton'
RunningSum              = require '../services/RunningSum'
ShareGameService        = require '../services/ShareGameService'
SolutionService         = require '../services/SolutionService'
Title                   = require '../services/Title'
Board                   = require '../views/Board'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
GoalContainer           = require '../views/GoalContainer'
GeneralTests            = require '../../tests/controllers/GeneralTests'

class MathSwipeController

  constructor: ->
    @gameScene = @createGameScene()
    @symbols = @getSymbols()
    @bindNewGameButton()
    @bindShareGameButton()
    HowToPlay.createHowToPlay @isMobile
    if @isMobile().any()?
      Title.mobileTitle()
    else
      @cursorToPointer()
    if ShareGameService.isSharedGame()
      @initializeSharedGame()
    else
      @initialize()

    # # Uncomment the following line to perform general tests
    # GeneralTests.tests @board

  initialize: ->
    length = 3
    inputs = []
    answers = []

    inputLengths = RandomizedFitLength.generate length * length

    @generateInputs inputLengths, inputs, answers

    console.log expression for expression in inputs
    console.log '\n'

    gameModel = @generateBoard inputs, length
    @goalContainer = new GoalContainer answers, Colors
    @board = new Board  gameModel, @gameScene, answers, @symbols,
                        @goalContainer, @isMobile().any()?, Cell,
                        Colors, ClickHandler, SolutionService,
                        BoardSolvedService, RunningSum
    ResetButton.bindClick @board

  initializeSharedGame: ->
    length = 3
    answers = []

    hashString = window.location.hash.slice 1, window.location.hash.length
    console.log hashString
    values = hashString.split "_"
    for i in [2...values.length]
      answers.push values[i]
    gameModel = @createSharedGrid values[0], length
    gameModel.length = length
    @goalContainer = new GoalContainer answers, Colors
    @board = new Board  gameModel, @gameScene, answers, @symbols,
                        @goalContainer, @isMobile().any()?, Cell,
                        Colors, ClickHandler, SolutionService,
                        BoardSolvedService, RunningSum
    ResetButton.bindClick @board


  createSharedGrid: (gridValues, length) ->
    grid = []
    index = 0
    for row in [0...length]
      grid.push []
      for col in [0...length]
        grid[row].push gridValues[index]
        index++
    grid

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

  # -------- Front-end -------- #

  bindShareGameButton: ->
    $('#share-game-button').click (e) =>
      ShareGameService.reloadPageWithHash @board
      ShareGameService.isSharedGame()

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

  cursorToPointer: ->
    $('#game').addClass('pointer')
    $('#game-button-wrapper').addClass('pointer')

  getSymbols: ->
    scene = new Two()
    svgs = $('#assets svg')
    symbols = []
    for svg, index in svgs
      symbols.push (scene.interpret svg)
      symbols[index].visible = false
    symbols

  # -------- Back-end -------- #

  generateBoard: (inputs, length) ->
    DFS.setEquationsOnGrid length, inputs, AdjacentCellsCalculator

  generateInputs: (inputLengths, inputs, answers) ->
    for inputSize in inputLengths
      value = -1
      while value < 1 or value > 300
        expression = ExpressionGenerator.generate inputSize
        value = InputSolver.compute expression
      answers.push (InputSolver.compute expression)
      inputs.push expression.split('')

  randExpression: (length) ->
    ExpressionGenerator.generate length


module.exports = MathSwipeController
