$ = require 'jquery'

class ResetButton

  @bindClick: (board) ->
    $('#reset-button').click (e) =>
      board.resetBoard()

  @unbindClick: ->
    $('#reset-button').unbind('click')
    ga 'send', 'event', 'board', 'reset'

module.exports = ResetButton
