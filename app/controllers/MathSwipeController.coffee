InputSolver = require '../services/InputSolver'
GameGrid    = require '../models/GameGrid'
Board       = require '../views/Board'
$           = require 'jQuery'

class MathSwipeController 

  constructor: ->
    console.log InputSolver.compute("1+2*3")
    gridModel = new GameGrid(4)

    svgs = $('#assets svg') 

    two = new Two(
      fullscreen: true
      autostart: true
      # width: 700
      # height: 700
    ).appendTo(document.getElementById('game'));

    symbols = []

    for s,i in svgs
      symbols.push (two.interpret s)
      symbols[i].visible = false



    @board = new Board gridModel, two

    two.update()

module.exports = MathSwipeController
