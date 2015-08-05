$ = require 'jquery'

class ResetButton

  constructor: (@board) ->

  bindClick: ->
    $('#reset-button').click (e) =>
      @board.resetBoard()

module.exports = ResetButton
