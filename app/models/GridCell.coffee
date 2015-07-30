class GridCell

  constructor: ->
    @value = ' '
    @isClicked = false

  isEmpty: => @value is ' '

module.exports = GridCell
