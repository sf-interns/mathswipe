$ = require 'jquery'

class ResetButton

  @bindClick: (board) ->
    $('#reset-button').click (e) =>
      board.resetBoard()
      $('#running-sum').html('')

  @unbindClick: ->
    $('#reset-button').unbind('click')

module.exports = ResetButton
