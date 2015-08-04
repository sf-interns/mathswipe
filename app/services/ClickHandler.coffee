$ = require 'jquery'

class ClickHandler

  constructor: (@board, two, @clicked=[]) ->
    @numClicked = @clicked.length
    return unless @board.cells?
    for row in @board.cells
      break if row.length is 0
      for cell in row
        @addToClicked (cell) if cell.isSelected

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
    @numClicked++
    @clicked.push cell

  removeFromClicked: (cell) ->
    @numClicked--
    @clicked.pop()

  resetClicked: ->
    while @numClicked > 0
      @unclickCell @lastClicked()

  firstClicked: ->
    @clicked[0]

  lastClicked: ->
    @clicked[@numClicked - 1]

  clickCell: (cell) ->
    # if cell is adjacent to lastClicked
    if @numClicked is 0 or @clicked.length is 0 or @areAdjacent cell, @lastClicked()
      return if @cell in @clicked
      cell.select()
      @addToClicked cell
    else
      @resetClicked()
      @clickCell cell

  areAdjacent: (cell, otherCell) ->
    return Math.abs(cell.row - otherCell.row) <= 1 and Math.abs(cell.col - otherCell.col)<=1

  unclickCell: (cell) ->
    last = @lastClicked()
    return null unless cell is @lastClicked()
    cell.unSelect()
    console.log @numClicked
    @removeFromClicked cell
    console.log @numClicked

module.exports = ClickHandler
