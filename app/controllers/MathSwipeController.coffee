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
    @initialize()
    @bindNewGameButton()
    HowToPlay.createHowToPlay @isMobile
    if @isMobile().any()?
      Title.mobileTitle()
    else
      @cursorToPointer()

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

    @gameModel = @generateBoard inputs, length
    @goalContainer = new GoalContainer answers, Colors
    @board = new Board  @gameModel, @gameScene, answers, @symbols,
                        @goalContainer, @isMobile().any()?, Cell,
                        Colors, ClickHandler, SolutionService,
                        BoardSolvedService, RunningSum
    ResetButton.bindClick @board

    # creating board without two.js
    @createBoard(3)
    @bindCellsClick(3)

# ---------------- no more two.js ------------------

  createBoard: (numRowCells) ->
    @setGridStyling numRowCells

    gridElem = $('#grid-container')
    for row in [0...numRowCells]
      gridRow = '<div id="grid-row-' + row + '" class="grid-row"></div>'
      gridElem.append(gridRow)
      for col in [0...numRowCells]
        gridCell = '<div id="grid-cell-' + row + '-' + col + '" class="grid-cell"></div>'
        $('#grid-row-' + row).append(gridCell)
        $('#grid-cell-' + row + '-' + col).css(@gridCellStyle)

    @createCells numRowCells
    @setDistance()

  setDistance: ->
     @dropDownDistance = $( '#cell-1-0' ).position().top

  setGridStyling: (numRowCells) ->
    gridSpacing = 15
    fieldWidth = Math.min(Math.max($( window ).width(), 310), 500)
    tileSize = (fieldWidth - gridSpacing * (numRowCells + 1)) / numRowCells
    @gridCellStyle = { width: tileSize, height: tileSize, "line-height": "#{tileSize}px" }
    $('#game-container').css({ width: fieldWidth, height: fieldWidth })

  createCells: (numRowCells) ->
    containerElem = $('#cell-container')
    for row in [0...numRowCells]
      cellRow = '<div id="cell-row-' + row + '" class="cell-row"></div>'
      containerElem.append(cellRow)
      for col in [0...numRowCells]
        cell = '<div id="cell-' + row + '-' + col + '" class="cell">' + @gameModel[row][col] + '</div>'
        $('#cell-row-' + row).append(cell)
        $('#cell-' + row + '-' + col).css(@gridCellStyle)

  pushCellToBottom: (row, col) ->
    $( "#cell-#{row}-#{col}" ).css( "transform", "translate(0, #{@dropDownDistance}px)" )

  bindCellsClick: (numRowCells) ->
    for row in [0...numRowCells]
      for col in [0...numRowCells]
        $('#cell-' + row + '-' + col).click (e) =>
          e.preventDefault()
          $(e.currentTarget).css( "transform", "translate(0, #{@dropDownDistance}px)" )
          console.log $(e.currentTarget).text()

  clearBoardElem: ->
    $('#grid-container').empty()
    $('#cell-container').empty()

  # -------- Front-end -------- #

  bindNewGameButton: ->
    $('#new-game-button').click (e) =>
      @gameScene.clear()
      @goalContainer.clearGoals()
      ResetButton.unbindClick()

      @clearBoardElem()

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
