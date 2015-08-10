$ = require 'jquery'

class BoardSolvedService

  isBoardCleared: (boardBottomRow) ->
    for value in boardBottomRow
      return false unless value is ' '
    return true

  newGameBoard: ->
    $( "#new-game-button" ).trigger( "click" );

module.exports = BoardSolvedService
