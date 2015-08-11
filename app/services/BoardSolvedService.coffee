$ = require 'jquery'

class BoardSolvedService

  @isCleared: (boardBottomRow) ->
    for value in boardBottomRow
      return false unless value is ' '
    true

  @createNewBoard: ->
    document.getElementById('new-game-button').disabled = false
    $('#new-game-button').trigger('click')

module.exports = BoardSolvedService
