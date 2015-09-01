$               = require 'jquery'
Tuple           = require '../models/Tuple'
TrackingService = require './TrackingService'

class ClickHandler

  # @isMobile: False is DESKTOP, True is MOBILE
  constructor: (@board, @solutionService, @goalContainer, @isMobile, @BoardSolvedService, @RunningSum) ->
    @clicked = []
    @mouseDown = false

  setMouseAsDown: ->
    @mouseDown = true

  setMouseAsUp: ->
    unless @isMobile
      @checkForSolution()
      @unselectAll()
      if @BoardSolvedService.isCleared @board
        TrackingService.boardEvent 'solved'
        @board.successAnimation()
      else if @goalContainer.isEmpty()
        @RunningSum.display @RunningSum.tilesEmptyString
    @mouseDown = false

  isMouseDown: ->
    @mouseDown

  isOnMobile: ->
    @isMobile

  bindDefaultMouseEvents: ->
    body = $('body')
    body.click (e) =>
      e.preventDefault()
      @unselectAll()
    body.mousedown (e) =>
      e.preventDefault()
    body.mouseup (e) =>
      e.preventDefault()
      @unselectAll() unless @isMobile
      @mousedown = false

  onSelect: (cell) ->
    unless @isSelected cell
      unless @isAdjacentToLast cell
        @unselectAll()
      @setMouseAsDown()
      @clicked.push cell
      cell.select()

      @solutionService.initialize @clicked
      @RunningSum.display @solutionService.solution, @solutionService.value

      # Keep for when we switch to swiping on mobile
      if @isMobile and @checkForSolution()
        @unselectAll()
        if @BoardSolvedService.isCleared @board
          @board.successAnimation()
    false

  onUnselect: (cell) ->
    if @isSelected cell
      if @clicked[@clicked.length - 1] is cell
        cell.unselect()
        @clicked.pop()
      else
        @unselectAll()
        throw "Last item in 'clicked' was not the given cell"

  isSelected: (cell) ->
    for iterCell in @clicked
      return true if cell is iterCell
    false

  unselectAll: ->
    unless $('#running-sum').html() is @RunningSum.solutionOperatorString
      @RunningSum.display @RunningSum.emptyString
    return if @clicked.length < 1
    for i in [@clicked.length - 1..0]
      @clicked[i].unselect()
    @clicked = []

  checkForSolution: () ->
    if @solutionService.isSolution()
      @goalContainer.deleteGoal @solutionService.valueIndex
      @board.deleteCells @clickedToTuples()
      return true
    return false

  isAdjacentToLast: (cell) ->
    return true if @clicked.length < 1
    last = @clicked[@clicked.length - 1]
    Math.abs(cell.row - last.row) <= 1 and Math.abs(cell.col - last.col) <= 1

  clickedToTuples: ->
    tuples = []
    for cell in @clicked
      tuples.push new Tuple cell.col, cell.row
    tuples

module.exports = ClickHandler
