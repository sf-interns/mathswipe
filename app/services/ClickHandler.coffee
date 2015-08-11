$ = require 'jquery'
Tuple = require '../models/Tuple'

class ClickHandler

  constructor: (@board, @solutionService, @goalContainer, @BoardSolvedService) ->
    @clicked = []
    @mouseDown = false
    @onMobile = false

  setMouseDown: (val) ->
    @checkForSolution() unless val
    @mouseDown = val

  isMouseDown: ->
    @mouseDown

  isOnMobile: ->
    @onMobile

  bindDefaultMouseEvents: ->
    body = $('body')
    body.click (e) =>
      e.preventDefault()
      @unselectAll()
    body.mousedown (e) =>
      e.preventDefault()
    body.mouseup (e) =>
      e.preventDefault()
      @setMouseDown false
      @unselectAll()

  onSelect: (cell) ->
    unless @isSelected cell
      unless @isAdjacentToLast cell
        @unselectAll()
      @setMouseDown true
      @clicked.push cell
      cell.select()
    false

  onUnselect: (cell) ->
    if @isSelected cell
      if @clicked[@clicked.length - 1] is cell
        cell.unselect()
        @clicked.pop()
      else
        throw "Last item in 'clicked' was not the given cell"

  isSelected: (cell) ->
    for iterCell in @clicked
      return true if cell is iterCell
    false

  unselectAll: ->
    return if @clicked.length < 1
    for i in [@clicked.length - 1..0]
      @clicked[i].unselect()
    @clicked = []

  checkForSolution: () ->
    if @solutionService.isSolution @clicked
      @goalContainer.deleteGoal @solutionService.valueIndex
      @board.deleteCells @clickedToTuples()
      if @BoardSolvedService.isCleared @board
        setTimeout (() => @BoardSolvedService.createNewBoard()), 100
    @unselectAll()

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
