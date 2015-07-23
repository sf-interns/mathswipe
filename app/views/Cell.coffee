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
    @board.x - (@board.size + @size) / 2 + col * @board.change

  getY: (row=@row)->
    @board.y - (@board.size + @size) / 2 + row * @board.change

  shiftTo: (row, col) ->
    @rect.translation.set @getX(col) + @board.change, @getY(row) + @board.change
    @two.update()

  delete: ->
    @hide()
    @isDeleted = true

module.exports = Cell
