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

    if @clickHandler?
      unless @clickHandler.isOnMobile()
        @bindMouseMove()
        @bindMouseUp()
        @bindMouseDown()
      else
        @bindClick()


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

  bindClick: ->
    $('#' + @cell.id).click (e) =>
      e.preventDefault()
      e.stopPropagation()
      return if @isDeleted
      unless @isSelected
        @clickHandler.onSelect this
      else
        @clickHandler.onUnselect this

  bindMouseMove: ->
    $('#' + @cell.id).mousemove (e) =>
      e.preventDefault()
      e.stopPropagation()
      return if @isDeleted
      if not @isSelected and @clickHandler.isMouseDown() and
      @inHitBox(e.offsetX, e.offsetY)
        @clickHandler.onSelect this

  bindMouseUp: ->
    $('#' + @cell.id).mouseup (e) =>
      e.preventDefault()
      e.stopPropagation()
      @clickHandler.setMouseDown false

  bindMouseDown: ->
    $('#' + @cell.id).mousedown (e) =>
      e.preventDefault()
      e.stopPropagation()
      return if @isDeleted
      unless @isSelected
        @clickHandler.onSelect this

  inHitBox: (mouseX, mouseY) ->
    # Within a box 70% of the actual
    shrinkSize = (0.70 * @size) / 2.0
    Math.abs(mouseX - @getX()) < shrinkSize and
    Math.abs(mouseY - @getY()) < shrinkSize

  select: ->
    @isSelected = true
    @setColor Colors.select

  unselect: ->
    @isSelected = false
    @setColor Colors.cell

  delete: ->
    @hide()
    @isDeleted = true

  x: -> @col

  y: -> @row

module.exports = Cell
