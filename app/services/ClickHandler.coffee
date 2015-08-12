$ = require 'jquery'
Tuple = require '../models/Tuple'

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
      @setMouseAsUp()

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
    @RunningSum.display ''
    return if @clicked.length < 1
    for i in [@clicked.length - 1..0]
      @clicked[i].unselect()
    @clicked = []

  checkForSolution: () ->
    if @solutionService.isSolution()
      @RunningSum.display ''
      @goalContainer.deleteGoal @solutionService.valueIndex
      @board.deleteCells @clickedToTuples()
      if @BoardSolvedService.isCleared @board
        setTimeout (() => @BoardSolvedService.createNewBoard()), 100
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

  addToClicked: (cell) ->
    return if cell.isDeleted
    @clicked.push cell

  removeFromClicked: ->
    @clicked.pop()

  resetClicked: ->
    @unclickCell cell for cell in @clicked by -1

  lastClicked: ->
    @clicked[@clicked.length - 1]

  clickCell: (cell) ->
    # if cell is adjacent to lastClicked
    if @clicked.length is 0 or @areAdjacent cell, @lastClicked()
      unless @cell in @clicked
        cell.select()
        @addToClicked cell
        if @solutionService.isSolution @clicked
          @goalContainer.deleteGoal @solutionService.valueIndex
          @board.deleteCells @tuplesClicked()
          @clicked = []
          if @BoardSolvedService.isCleared @board.boardValues[@board.dimension - 1]
            document.getElementById('new-game-button').disabled = true
            @board.successAnimation()
            setTimeout (() => @BoardSolvedService.createNewBoard()), 1100
    else
      @resetClicked()
      @clickCell cell

  areAdjacent: (cell, otherCell) ->
    return Math.abs(cell.row - otherCell.row) <= 1 and Math.abs(cell.col - otherCell.col) <= 1

  unclickCell: (cell) ->
    last = @lastClicked()
    return null unless cell is @lastClicked()
    cell.unSelect()
    @removeFromClicked cell

module.exports = ClickHandler
