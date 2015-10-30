$ = require 'jquery'

class ResetButton

  @bindClick: (board, RunningSum) ->
    $('#reset-button').click (e) =>
      board.resetBoard()
      RunningSum.empty()

  @unbindClick: ->
    $('#reset-button').unbind('click')

module.exports = ResetButton
