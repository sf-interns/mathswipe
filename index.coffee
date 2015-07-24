Two                 = require 'two.js'
MathSwipeController = require './app/controllers/MathSwipeController'
Tuple               = require './app/models/Tuple'
$                   = require 'jquery'


sleep = (ms) ->
  start = new Date().getTime()
  console.log 'sleeping' while new Date().getTime() - start < ms

game = new MathSwipeController

solution = [(new Tuple 1, 1), (new Tuple 2, 2), (new Tuple 3, 3)]

game.board.deleteCells solution


