class GridCell

  constructor: ->
    @value = ' '
    @isClicked = false
    @isDeleted = false

  isEmpty: => @value is ' '

  delete: => @isDeleted = true

module.exports = GridCell
