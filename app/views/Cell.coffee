$      = require 'jquery'
Colors = require './Colors'

class Cell

  constructor: (@col, @row, @size, @scene, @board, @clickHandler, symbolBlueprint) ->
    @isDeleted = false
    @isSelected = false
    @rect = @scene.makeRectangle @getX(), @getY(), @size, @size
    if symbolBlueprint
      @cell = @scene.makeGroup @rect, (@newSymbol symbolBlueprint)
    else
      @cell = @scene.makeGroup @rect
    @scene.update()

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
    @scene.update()

  setBorder: (c) ->
    @rect.stroke = c
    @rect.linewidth = 6
    @scene.update()

  hide: ->
    @cell.visible = false
    @scene.update()

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

    @scene.bind('update', (frameCount) =>
      dist = start.distanceTo end

      if dist < .00001
        @cell.translation.clone end
        @scene.unbind 'update'

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
