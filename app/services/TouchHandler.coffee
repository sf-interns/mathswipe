$ = require 'jquery-mobile'
Tuple = require '../models/Tuple'

class TouchHandler

  constructor: (@board, two, @solutionService, @goalContainer, @clicked = []) ->
    @mouseIsDown = false
    return unless @board.cells?
    for row in @board.cells
      break if row.length is 0
      for cell in row
        (@addToClicked cell) if cell.isSelected

  bindDefaultClick: ->
    $('body').tap (e) =>
      e.preventDefault()
      @resetClicked()
      console.log 'mouseClick'
    this

  bindDefaultMousedown: ->
    $('body').vmousedown (e) =>
      e.preventDefault()
      @mouseIsDown = true
    this

  bindDefaultMouseup: ->
    $('body').vmouseup (e) =>
      e.preventDefault()
      @mouseIsDown = false
      @resetClicked()
    this

  bindClickTo: (cells) ->
    if cells.bindClick?
      cells.bindClick()
      return
    for row in cells
      if row.bindClick?
        row.bindClick()
        return
      for cell in row
        if cell.bindClick?
          cell.bindClick()
        else
          console.log 'WARN: object not 2D arrays or simpler or no BindClick method'

  bindMouseenterTo: (cells) ->
    if cells.bindMouseenter?
      cells.bindMouseenter()
      return
    for row in cells
      if row.bindMouseenter?
        row.bindMouseenter()
        return
      for cell in row
        if cell.bindMouseenter?
          cell.bindMouseenter()
        else
          console.log 'WARN: object not 2D arrays or simpler or no bindMouseenter method'

   bindMouseupTo: (cells) ->
    if cells.bindMouseup?
      cells.bindMouseup()
      return
    for row in cells
      if row.bindMouseup?
        row.bindMouseup()
        return
      for cell in row
        if cell.bindMouseup?
          cell.bindMouseup()
        else
          console.log 'WARN: object not 2D arrays or simpler or no bindMouseup method'

  bindMousedownTo: (cells) ->
    if cells.bindMousedown?
      cells.bindMousedown()
      return
    for row in cells
      if row.bindMousedown?
        row.bindMousedown()
        return
      for cell in row
        if cell.bindMousedown?
          cell.bindMousedown()
        else
          console.log 'WARN: object not 2D arrays or simpler or no bindMousedown method'

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
    cell.unSelect()
    @removeFromClicked cell

  onEnter: (cell) ->
    console.log @mouseIsDown
    if @mouseIsDown and (@clicked.length is 0 or @areAdjacent cell, @lastClicked()) and @cell not in @clicked
      @clickCell cell

  onDown: (cell) ->
    @mouseIsDown = true
    @clickCell cell

  onUp: (cell) ->
    @mouseIsDown = false
    @checkSolution()


module.exports = ClickHandler
