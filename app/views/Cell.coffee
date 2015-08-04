$      = require 'jquery'
Colors = require './colors'

class Cell

  constructor: (@col, @row, @size, @two, @board, @clickHandler, symbols) ->
    @isDeleted = false
    @isSelected = false
    @rect = @two.makeRectangle @getX(), @getY(), @size, @size
    if symbols? 
      @cell = @two.makeGroup @rect, (@newSymbol symbols, 8)
    else 
      @cell = @two.makeGroup @rect
    @two.update()

  newSymbol: (symbols, value)->
    symbol = symbols[value].clone()
    symbol.translation.set @getX() - 0.4*@size, @getY() - 0.4*@size
    symbol.scale = (@size / 480) *.8
    symbol.fill = 'black'
    symbol

  setColor: (c) ->
    @color = c
    @rect.fill = c
    @two.update()

  setBorder: (c) ->
    @rect.stroke = c
    @rect.linewidth = 6
    @two.update()

  hide: ->
    @cell.visible = false
    @two.update()

  getX: (col = @col) ->
    @board.x - (@board.size + @size) / 2 + (col + 1) * @board.change

  getY: (row = @row) ->
    @board.y - (@board.size + @size) / 2 + (row + 1) * @board.change

  setIndices: (row, col) ->
    if row? and col?
      @row = row
      @col = col

  shiftTo: (row, col) ->
    end = new Two.Vector @getX(col), @getY(row)
    start = new Two.Vector @getX(), @getY() 
    goingDown = end.y > start.y

    @two.bind('update', (frameCount) =>
      dist = start.distanceTo end

      if dist < .00001
        @cell.translation.clone end
        @two.unbind 'update'

      delta = new Two.Vector 0, (dist * .125)
      if goingDown 
        @cell.translation.addSelf delta
        start = start.addSelf delta
      else 
        @cell.translation.subSelf delta
        start = start.subSelf delta
    ).play()

    @setIndices row, col

  select: ->
    @isSelected = true
    @setColor Colors.select

  unSelect: ->
    @isSelected = false
    @setColor Colors.cell

  bindClick: ->
    return unless @clickHandler?
    $(@cell._renderer.elem).click (e) =>
      e.preventDefault()
      return if @isDeleted
      if @isSelected
        @clickHandler.unclickCell this
      else
        @clickHandler.clickCell this
      e.stopPropagation()

  x: -> @col

  y: -> @row

  delete: ->
    @hide()
    @isDeleted = true

module.exports = Cell
