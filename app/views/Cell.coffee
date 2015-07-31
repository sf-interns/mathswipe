class Cell

  constructor: (@col, @row, @size, @two, @board) ->
    @isDeleted = false
    @rect = @two.makeRectangle @getX(), @getY(), @size, @size
    @two.update()

  setColor: (c) =>
    @color = c
    @rect.fill = c
    @two.update()

  setBorder: (c) =>
    @rect.stroke = c
    @rect.linewidth = 6
    @two.update()

  hide: =>
    @rect.opacity = 0
    @two.update()

  getX: (col = @col) =>
    @board.x - (@board.size + @size) / 2 + (col + 1) * @board.change

  getY: (row = @row) =>
    @board.y - (@board.size + @size) / 2 + (row + 1) * @board.change

  moveTo: (row, col) =>
    @shiftTo row, col
    @updateLoc row, col

  shiftTo: (row, col) =>
    end = new Two.Vector @getX(col), @getY(row)
    start = new Two.Vector @getX(), @getY()

    @two.bind('update', (frameCount) =>
      dist = start.distanceTo end

      if dist < .00000001
        @rect.translation.clone end
        @two.unbind 'update'

      delta = new Two.Vector 0, (dist * .125)
      @rect.translation.addSelf delta
      start = start.addSelf delta
    ).play()

  updateLoc: (row, col) =>
    @row = row
    @col = col

  delete: =>
    @hide()
    @isDeleted = true

module.exports = Cell
