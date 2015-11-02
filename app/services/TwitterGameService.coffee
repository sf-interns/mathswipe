$ = require 'jquery'

class TwitterGameService

  @setTweet: ->
    possible = ['Play MathSwipe with me! Try to beat my score at',
                'Play MathSwipe with me! Try to solve my board at',
                'Play MathSwipe with me! Solve my puzzle at']
    text = possible[Math.floor(Math.random() * 3)]
    $( '#tweet' ).attr( 'data-text' , text )

module.exports = TwitterGameService
