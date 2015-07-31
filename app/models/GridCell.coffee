class GridCell

  constructor: ->
    @value = ' '
    @isClicked = false
    @isDeleted = false

  isEmpty: => @value is ' '

  delete: =>
    @isDeleted = true
    @value = ' '

module.exports = GridCell
