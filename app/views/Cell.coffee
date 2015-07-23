class Cell

  constructor: (@col, @row, @size, @two, @board) ->
    @isDeleted = false
    @rect = (@two.makeRectangle @getX(), @getY(), @size, @size)
    # @board.add @rect
    @two.update()

  setColor: (c) =>
    @color = c
    @rect.fill = c
    @two.update()

  hide: ->
    @setColor '#FFFFFF'
    @rect.opacity = 0

  getX: (col=@col) =>
    @board.x - (@board.size + @size) / 2 + (col + 1) * @board.change

  getY: (row=@row)->
    @board.y - (@board.size + @size) / 2 + (row + 1) * @board.change

  shiftTo: (row, col) ->
    @rect.translation.set @getX(col), @getY(row)
    @two.update()

  delete: ->
    @hide()
    @isDeleted = true

module.exports = Cell
