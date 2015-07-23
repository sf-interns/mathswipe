Two                 = require 'two.js'
MathSwipeController = require './app/controllers/MathSwipeController'
$                   = require 'jquery'


sleep = (ms) ->
  start = new Date().getTime()
  console.log 'sleeping' while new Date().getTime() - start < ms

game = new MathSwipeController

game.board.deleteCellAt 3, 4

