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
Board                   = require '../views/Board'
GoalContainer           = require '../views/GoalContainer'
Cell                    = require '../views/Cell'
Colors                  = require '../views/Colors'
GeneralTests            = require '../../tests/controllers/GeneralTests'
$                       = require 'jquery'

class MathSwipeController

  constructor: ->
    @gameScene = @createGameScene()
    @symbols = @getSymbols()
    @initialize()
    @bindNewGameButton()
    @createHowToPlay()
    # GeneralTests.tests(@board)

  initialize: ->
    length = 3
    inputs = []
    answers = []

    inputLengths = RandomizedFitLength.generate length * length
    for inputSize in inputLengths
      value = -1
      while value < 1 or value > 300
        expression = ExpressionGenerator.generate inputSize
        value = InputSolver.compute expression
      answers.push (InputSolver.compute expression)
      inputs.push expression.split('')

    console.log i for i in inputs
    console.log '\n'

    gameModel = @generateBoard inputs, length
    @goalContainer = new GoalContainer answers, Colors
    @board = new Board gameModel, @gameScene, answers, @symbols, @goalContainer, @isMobile().any()?, Cell, Colors, ClickHandler, SolutionService, BoardSolvedService, RunningSum
    ResetButton.bindClick @board
    unless @isMobile().any()?
      @cursorToPointer()

  cursorToPointer: ->
    $('#game').addClass('pointer')
    $('#game-button-wrapper').addClass('pointer')

  createHowToPlay: ->
    if @isMobile().any()?
      $('#how-to-play').append('<b>How To Play:</b> Solve the puzzle by
        clearing the board. Click adjacent tiles to create an
        equation, and if it equals an answer, the tiles disappear!')
    else
      $('#how-to-play').append('<b>How To Play:</b> Solve the puzzle by
        clearing the board. Drag your mouse across the tiles to create an
        equation, and if it equals an answer, the tiles disappear!')

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



module.exports = MathSwipeController
