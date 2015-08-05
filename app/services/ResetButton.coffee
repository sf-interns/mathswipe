$ = require 'jquery'

class ResetButton

  constructor: (@board) ->

  bindClick: ->
    # return unless @clickHandler?
    $('#reset-button').click (e) =>
      @board.resetBoard()

module.exports = ResetButton
