$      = require 'jquery'
Colors = require './colors'

class Cell

  constructor: (@col, @row, @size, @two, @board, @clickHandler) ->
    @isDeleted = false
    @isSelected = false
    @rect = @two.makeRectangle @getX(), @getY(), @size, @size
    @two.update()

  setColor: (c) ->
    @color = c
    @rect.fill = c
    @two.update()

  setBorder: (c) ->
    @rect.stroke = c
    @rect.linewidth = 6
    @two.update()

  hide: ->
    @rect.visible = false
    @two.update()

  getX: (col = @col) ->
    @board.x - (@board.size + @size) / 2 + (col + 1) * @board.change

  getY: (row = @row) ->
    @board.y - (@board.size + @size) / 2 + (row + 1) * @board.change

  shiftTo: (row, col) ->
    end = new Two.Vector @getX(col), @getY(row)
    start = new Two.Vector @getX(), @getY() 
    goingDown = end.y > start.y

    @two.bind('update', (frameCount) =>
      dist = start.distanceTo end

      if dist < 1
        @rect.translation.set (@getX col), (@getY row)
        @two.unbind 'update'

      delta = new Two.Vector 0, (dist * .125)
      if goingDown then @rect.translation.addSelf delta
      else @rect.translation.subSelf delta
      start = start.addSelf delta
    ).play()

  select: ->
    return unless @clickHandler?
    @isSelected = true
    @setColor Colors.select

  unSelect: ->
    return unless @clickHandler?
    @isSelected = false
    @setColor Colors.cell

  bindClick: ->
    return unless @clickHandler?
    console.log 'bindClick'
    $(@rect._renderer.elem).click (e) =>
      console.log @col, @row, 'isSelected', @isSelected, 'isDeleted', @isDeleted
      e.preventDefault()
      return if @isDeleted
      if @isSelected
        @unSelect()
      else
        @select()

  delete: ->
    @hide()
    @isDeleted = true

module.exports = Cell
