$      = require 'jquery'
Colors = require './Colors'

class Cell

  constructor: (@col, @row, @board, @clickHandler, value, @gridCellStyle) ->
    @isDeleted = @isSelected = false
    cell = '<div id="cell-' + @row + '-' + @col + '" class="cell">' + value + '</div>'
    $('#cell-row-' + @row).append(cell)
    $('#cell-' + @row + '-' + @col).css(@gridCellStyle)
    @setColor Colors.cell
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
    $('#cell-' + @row + '-' + @col).empty()

  setIndices: (row, col) ->
    if row? and col?
      $('#cell-' + @row + '-' + @col).attr( 'id', 'cell-' + row + '-' + col )
      @row = row
      @col = col

  shiftTo: (row, col) ->
    transform = document.getElementById("cell-#{@row}-#{@col}").style.transform
    transform = transform.split(' ')[1]?.match( /[-+]?[0-9]*\.?[0-9]*/g, '')
    distance = @board.dropDownDistance * (row - @row)
    if transform? and not isNaN parseFloat transform[0]
      distance += parseFloat transform[0]
    $( "#cell-#{@row}-#{@col}" ).css( "transform", "translate(0, #{distance}px)" )
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
