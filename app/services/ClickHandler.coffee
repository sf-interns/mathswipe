class ClickHandler

  @numClicked = 0

  constructor: (@board, @clicked=[]) ->
    @numClicked = @clicked.length
    return unless @board.cells?
    for row in @board.cells
      break if row.length is 0
      for cell in row
        @addToClicked (cell) if cell.isSelected
    console.log @clicked

  bindClickToCells: (cells) ->
    for row in cells
      for cell in row
        cell.rect

  addToClicked: (cell) ->
    return if cell.isDeleted
    @numClicked++
    @clicked.push cell

  removeFromClicked: (cell, isFirst)->
    @numClicked--
    if isFirst then @clicked.shift() else @clicked.pop()

  firstClicked: ->
    @clicked[0]

  lastClicked: ->
    @clicked[@numClicked - 1]

  unClickCell: (cell) ->
    return null unless cell is @firstClicked() or cell is @lastClicked()
    cell.unSelect()
    @removeFromClicked cell, @firstClicked()

module.exports = ClickHandler
