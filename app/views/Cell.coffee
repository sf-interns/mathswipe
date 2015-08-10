$      = require 'jquery'
Colors = require './Colors'

class Cell

  constructor: (@col, @row, @size, @two, @board, @clickHandler, symbolBlueprint) ->
    @isDeleted = false
    @isSelected = false
    @rect = @two.makeRectangle @getX(), @getY(), @size, @size
    if symbolBlueprint
      @cell = @two.makeGroup @rect, (@newSymbol symbolBlueprint)
    else
      @cell = @two.makeGroup @rect
    @two.update()

  newSymbol: (blueprint)->
    offset = - @size * 4 / 10
    symbol = blueprint.clone()
    symbol.translation.set @getX() + offset, @getY() + offset
    symbol.scale = (@size / 100) *.8
    symbol.noStroke().fill = Colors.symbol
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
      e.stopPropagation()
      if @isSelected
        @clickHandler.unclickCell this
      else
        @clickHandler.clickCell this

  bindMouseenter: ->
    return unless @clickHandler?
    $(@cell._renderer.elem).mouseenter (e) =>
      e.preventDefault()
      return if @isDeleted
      e.stopPropagation()
      @clickHandler.onEnter this unless @isSelected

  bindMouseup: ->
    return unless @clickHandler?
    $(@cell._renderer.elem).mouseup (e) =>
      e.preventDefault()
      @clickHandler.onUp this
      e.stopPropagation()

  bindMousedown: ->
    return unless @clickHandler?
    $(@cell._renderer.elem).mousedown (e) =>
      e.preventDefault()
      return if @isDeleted
      e.stopPropagation()
      @clickHandler.onDown this unless @isSelected

  x: -> @col

  y: -> @row

  delete: ->
    @hide()
    @isDeleted = true

module.exports = Cell
