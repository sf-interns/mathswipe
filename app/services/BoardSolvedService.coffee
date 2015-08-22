$ = require 'jquery'

class BoardSolvedService

  @isCleared: (board) ->
    dim = board.dimension
    for value in board.boardValues[dim - 1]
      return false unless value is ' '
    true

  @createNewBoard: ->
    $('#new-game-button').trigger('click')
    ga 'event', 'board', 'new game'

module.exports = BoardSolvedService
