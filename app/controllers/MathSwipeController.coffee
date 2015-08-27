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
    HowToPlay.createHowToPlay @isMobile
    if @isMobile().any()?
      Title.mobileTitle()
    else
      @cursorToPointer()
    @initialize window.location.hash

    # # Uncomment the following line to perform general tests
    # GeneralTests.tests @board

  initialize: (hash) ->
    answers = []

    if hash? and hash isnt ''
      hashString = window.location.hash.slice 1, window.location.hash.length
      values = hashString.split '_'
      length = Math.sqrt values[0].length
      for i in [1...values.length]
        answers.push parseInt values[i]
      gameModel = @createSharedGrid values[0], length
    else
      length = 3
      inputs = []
      inputLengths = RandomizedFitLength.generate length * length
      @generateInputs inputLengths, inputs, answers
      console.log expression for expression in inputs
      console.log '\n'
      solutionPlacements = []
      gameModel = @generateBoard inputs, length, solutionPlacements

    @goalContainer = new GoalContainer answers, Colors
    @board = new Board  gameModel, @gameScene, answers, @symbols,
                        @goalContainer, @isMobile().any()?, Cell,
                        Colors, ClickHandler, SolutionService,
                        BoardSolvedService, RunningSum
    ResetButton.bindClick @board
    ShareGameService.reloadPageWithHash @board, solutionPlacements, inputs

  createSharedGrid: (gridValues, length) ->
    grid = []
    index = 0
    for row in [0...length]
      grid.push []
      for col in [0...length]
        grid[row].push gridValues[index++]
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

  bindNewGameButton: ->
    $('#new-game-button').click (e) =>
      @gameScene.clear()
      @goalContainer.clearGoals()
      ResetButton.unbindClick()
      @initialize (window.location.hash = '')

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
