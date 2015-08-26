$      = require 'jquery'
Colors = require './Colors'

class Cell

  constructor: (@col, @row, @board, @clickHandler, value, @gridCellStyle) ->
    @isDeleted = @isSelected = false
    cell = '<div id="cell-' + @row + '-' + @col + '" class="cell">' + value + '</div>'
    $('#cell-row-' + @row).append(cell)
    $('#cell-' + @row + '-' + @col).css(@gridCellStyle)
    # @rect = @scene.makeRectangle @getX(), @getY(), @size, @size

    # unless symbolBlueprint? and @clickHandler?
    #   @cell = @rect
    #   @scene.update()
    #   return

    # hitboxSize = 0.7 * @size
    # @hitbox = @scene.makeRectangle @getX(), @getY(), hitboxSize, hitboxSize
    # @hitbox.noStroke()

    # @cloneSymbol symbolBlueprint
    # @hitboxGroup = @scene.makeGroup @hitbox, @symbol
    # @cell = @scene.makeGroup @rect, @hitboxGroup
    # @scene.update()

    unless @clickHandler.isOnMobile()
      @bindMouseOver()
      @bindMouseUp()
      @bindMouseDown()
    else
      @bindClick()

  setColor: (c) ->
    @color = c
    $('#cell-' + @row + '-' + @col).css( 'color', c )
    # if @hitbox? then @hitbox.fill = c

  setBorder: (c) ->
    @rect.stroke = c
    @rect.linewidth = 6

  hide: ->
    @cell.visible = false

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
    $('#cell-' + @row + '-' + @col).click (e) =>
      e.preventDefault()
      e.stopPropagation()
      return if @isDeleted
      unless @isSelected
        @clickHandler.onSelect this
      else
        @clickHandler.onUnselect this

  bindMouseOver: ->
    $('#cell-' + @row + '-' + @col).mouseover (e) =>
      e.preventDefault()
      e.stopPropagation()
      return if @isDeleted
      if not @isSelected and @clickHandler.isMouseDown()
          @clickHandler.onSelect this

  bindMouseUp: ->
    $('#cell-' + @row + '-' + @col).mouseup (e) =>
      e.preventDefault()
      e.stopPropagation()
      @clickHandler.setMouseAsUp()

  bindMouseDown: ->
    $('#cell-' + @row + '-' + @col).mousedown (e) =>
      e.preventDefault()
      e.stopPropagation()
      return if @isDeleted
      unless @isSelected
        @clickHandler.onSelect this

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
