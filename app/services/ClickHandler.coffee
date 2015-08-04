$ = require 'jquery'

class ClickHandler

  constructor: (@board, two, @clicked = []) ->
    return unless @board.cells?
    for row in @board.cells
      break if row.length is 0
      for cell in row
        (@addToClicked cell) if cell.isSelected

  bindDefaultClick: (board) ->
    $('body').click (e) =>
      e.preventDefault()
      @resetClicked()

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
