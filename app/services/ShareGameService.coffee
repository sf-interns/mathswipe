$ = require 'jquery'

class ShareGameService

  @setMessage: ->
    possible = ['Play MathSwipe with me! Try to beat my score at',
                'Play MathSwipe with me! Try to solve my board at',
                'Play MathSwipe with me! Solve my puzzle at']
    text = possible[Math.floor(Math.random() * 3)]
    $( '#tweet' ).attr( 'data-text' , text )
    console.log $('#fb-share')
    $( '#fb-share' ).attr( 'data-href' , window.location.hash )

module.exports = ShareGameService
