$ = require 'jquery'

class BoardSolvedService

  @isCleared: (boardBottomRow) ->
    for value in boardBottomRow
      return false unless value is ' '
    true

  @createNewBoard: ->
    $('#new-game-button').trigger('click')

module.exports = BoardSolvedService
