$ = require 'jquery'

class ResetButton

  @bindClick: (board) ->
    $('#reset-button').click (e) =>
      board.resetBoard()

module.exports = ResetButton
