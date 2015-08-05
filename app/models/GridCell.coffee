class GridCell

  constructor: (@x, @y) ->
    @value = ' '
    @isClicked = false

  isEmpty: => @value is ' '

module.exports = GridCell
