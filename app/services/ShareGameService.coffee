$ = require 'jquery'

class ShareGameService

  @reloadPageWithHash: (board) ->
    hashVal = ''
    for row in board.initialValues
      for col in row
        hashVal = hashVal + col.toString()
    for goal in board.goalContainer.inputs
      hashVal = hashVal + '_' + goal
    window.location.hash = hashVal

  @isSharedGame: ->
    if window.location.hash isnt ''
      console.log window.location.hash

module.exports = ShareGameService
