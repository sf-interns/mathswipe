InputSolver = require '../services/InputSolver'
GameGrid    = require '../models/GameGrid'
Board    = require '../views/Board'

class MathSwipeController 

  constructor: ->
    console.log InputSolver.compute("1+2*3")
    @gridModel = new GameGrid(7)

    @two = new Two(
      fullscreen: true
      autostart: true
    ).appendTo(document.body);

    @board = new Board @gridModel, @two

    @two.update()

module.exports = MathSwipeController
