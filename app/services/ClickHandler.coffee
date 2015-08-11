$ = require 'jquery'
Tuple = require '../models/Tuple'

class ClickHandler

  constructor: (@board, two, @solutionService, @goalContainer, @clicked = []) ->
    @mouseDown = false
    return unless @board.cells?
    for row in @board.cells
      break if row.length is 0
      for cell in row
        (@addToClicked cell) if cell.isSelected

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

  tuplesClicked: () ->
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

  checkSolution: () ->
    return false unless @solutionService.isSolution @clicked
    @goalContainer.deleteGoal @solutionService.valueIndex
    @board.deleteCells @tuplesClicked()
    @clicked = []
    true

  clickCell: (cell) ->
    # if cell is adjacent to lastClicked
    if @clicked.length is 0 or @areAdjacent cell, @lastClicked()
      unless @cell in @clicked
        cell.select()
        @addToClicked cell
    else
      @resetClicked()
      @clickCell cell

  areAdjacent: (cell, otherCell) ->
    return Math.abs(cell.row - otherCell.row) <= 1 and Math.abs(cell.col - otherCell.col) <= 1

  unclickCell: (cell) ->
    last = @lastClicked()
    return null unless cell is @lastClicked()
    cell.unselect()
    @removeFromClicked cell

  onEnter: (cell) ->
    console.log @mouseDown
    if @mouseDown and (@clicked.length is 0 or @areAdjacent cell, @lastClicked()) and @cell not in @clicked
      @clickCell cell

  onDown: (cell) ->
    @mouseDown = true
    @clickCell cell

  onUp: (cell) ->
    @mouseDown = false
    @checkSolution()




  setMouseDown: (val) ->
    @checkForSolution() unless val
    @mouseDown = val

  isMouseDown: ->
    @mouseDown

  onSelect: (cell) ->
    unless @isSelected cell
      @clicked.push cell

  onUnselect: (cell) ->
    if @isSelected cell
      if @clicked[@clicked.length - 1] is cell
        cell.unselect()
        @clicked.pop()
      else
        throw "Last item in 'clicked' was not the given cell"

  unselectAll: ->
    return if @clicked.length < 1
    for i in [@clicked.length - 1..0]
      @clicked[i].unselect()
    @clicked = []

  isSelected: (cell) ->
    for iterCell in @clicked
      return true if cell is iterCell
    false

  checkForSolution: () ->
    if @solutionService.isSolution @clicked
      @goalContainer.deleteGoal @solutionService.valueIndex
      @board.deleteCells @tuplesClicked()
    @unselectAll()

module.exports = ClickHandler
