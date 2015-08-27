$ = require 'jquery'

class ShareGameService

  @reloadPageWithHash: (board) ->
    hashVal = ''
    for row in board.initialValues
      for col in row
        hashVal += col.toString()
    for goal in board.goalContainer.inputs
      hashVal += '_' + goal
    window.location.hash = hashVal

module.exports = ShareGameService
