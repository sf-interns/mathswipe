TwitterGameService = require './TwitterGameService'

class ShareGameService

  @setMessage: ->
    TwitterGameService.setTweet()

module.exports = ShareGameService
