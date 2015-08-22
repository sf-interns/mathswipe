$               = require 'jquery'
TrackingService = require './TrackingService'

class ResetButton

  @bindClick: (board) ->
    $('#reset-button').click (e) =>
      board.resetBoard()

  @unbindClick: ->
    $('#reset-button').unbind('click')

module.exports = ResetButton
