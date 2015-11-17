$                       = require 'jquery'
AdjacentCellsCalculator = require '../services/AdjacentCellsCalculator'
BoardSolvedService      = require '../services/BoardSolvedService'
ClickHandler            = require '../services/ClickHandler'
DFS                     = require '../services/DFS'
ExpressionGenerator     = require '../services/ExpressionGenerator'
HashingService          = require '../services/HashingService'
HowToPlay               = require '../services/HowToPlay'
InputSolver             = require '../services/InputSolver'
RandomizedFitLength     = require '../services/RandomizedFitLength'
ResetButton             = require '../services/ResetButton'
RunningSum              = require '../services/RunningSum'
ShareGameService        = require '../services/ShareGameService'
SolutionService         = require '../services/SolutionService'
Title                   = require '../services/Title'
TrackingService         = require '../services/TrackingService'
Board                   = require '../views/Board'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
GoalContainer           = require '../views/GoalContainer'
GeneralTests            = require '../../tests/controllers/GeneralTests'

class MathSwipeController

  constructor: ->
    length = 3
    @gameScene = @createGameScene()
    @symbols = @getSymbols()
    @bindNewGameButton()
    HowToPlay.createHowToPlay @isMobile
    if @isMobile().any()?
      TrackingService.mobileView()
      Title.mobileTitle()
    else
      TrackingService.desktopView()
      @cursorToPointer()
    ShareGameService.setMessage()
    @initialize()

    # # Uncomment the following line to perform general tests
    # GeneralTests.tests @board

  initialize: () ->
    length = 3
    solutionPlacements = []
    inputLengths = []
    boardValues = []
    inputs = []
    goals = []

    decoded = HashingService.decodeMap()
    [boardValues, goals, solutionPlacements] = HashingService.parse decoded

    if @malformedDecode boardValues, goals, solutionPlacements
      inputLengths    = RandomizedFitLength.generate length ** 2
      [inputs, goals] = @generateInputs inputLengths
      boardValues     = @generateBoard inputs, length, solutionPlacements

    @goalContainer = new GoalContainer goals, Colors
    @board = new Board  boardValues, @gameScene, goals, @symbols,
                        @goalContainer, @isMobile().any()?, Cell,
                        Colors, ClickHandler, SolutionService,
                        BoardSolvedService, RunningSum

    ResetButton.bindClick @board, RunningSum
    RunningSum.empty()

    @createNewGame() unless HashingService.reloadPageWithHash(@board,
                                            solutionPlacements, SolutionService)

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

  bindNewGameButton: ->
    $('#new-game-button').click (e) =>
      TrackingService.boardEvent 'new game'
      @createNewGame()

  createNewGame: ->
    @gameScene.clear()
    @goalContainer.clearGoals()
    ResetButton.unbindClick()
    HashingService.emptyHash()
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

  generateBoard: (inputs, length, solutionPlacements) ->
    DFS.setEquationsOnGrid length, inputs, AdjacentCellsCalculator, solutionPlacements

  generateInputs: (inputLengths, goals = [], inputs = []) ->
    for inputSize in inputLengths
      value = -1
      while value < 1 or value > 300
        expression = ExpressionGenerator.generate inputSize
        value = InputSolver.compute expression
      goals.push (InputSolver.compute expression)
      inputs.push (expression.split(''))
    [inputs, goals]

  malformedDecode: (boardValues, goals, solutionPlacements) ->
    boardValues.length < 1 or goals.length < 1 or solutionPlacements.length < 1

  randExpression: (length) ->
    ExpressionGenerator.generate length


module.exports = MathSwipeController
