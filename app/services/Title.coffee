$ = require 'jquery'

class Title

  @mobileTitle: ->
    elemById = $('#title')
    elemById.css('font-size', '16vw')

module.exports = Title
