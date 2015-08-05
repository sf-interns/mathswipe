$ = require 'jquery'

class ResetButton

  constructor: (@clickHandler) ->

  bindClick: ->
    return unless @clickHandler?
    $('#reset-button').click (e) =>
      console.log "cliked reset button"


module.exports = ResetButton
