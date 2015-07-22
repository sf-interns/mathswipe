InputSolver = require '../services/InputSolver'
GameGrid    = require '../models/GameGrid'
class MathSwipeController 

  constructor: ->
    console.log InputSolver.compute("1+2*-3")
    gridModel = new GameGrid(3)
    
    two = new Two(
      fullscreen: true
      autostart: true
    ).appendTo(document.body);
    
    oldHeight = two.height

    size = two.height * .80
    offset = size * .025
    width = ( size - offset ) / gridModel.dimension - offset

    boardX = ( two.width ) / 2
    boardY = ( two.height ) / 2 
    boardY = if boardY < size / 2 then size / 2 else boardY

    board = two.makeRectangle boardX, boardY, size, size
    board.fill = '#F0F8FF'

    startX = boardX - (size + width) / 2
    startY = boardY - (size + width) / 2

    change = offset + width

    gridView = []
    for i in [1..gridModel.dimension]
      gridView.push []
      for j in [1..gridModel.dimension]
        rect = (two.makeRectangle startX + j * change, startY + i * change, width, width)
        rect.fill = '#FFEBCD'
        gridView.push rect


module.exports = MathSwipeController
