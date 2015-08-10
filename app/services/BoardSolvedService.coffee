$ = require 'jquery'

class BoardSolvedService

  constructor: (@board) ->

  isBoardCleared: (boardBottomRow) ->
    console.log boardBottomRow
    for value in boardBottomRow
      return false unless value is ' '
    return true

  newGameBoard: (@board) ->


module.exports = BoardSolvedService
