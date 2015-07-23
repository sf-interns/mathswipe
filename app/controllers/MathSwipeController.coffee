InputSolver = require '../services/InputSolver'
GameGrid    = require '../models/GameGrid'

class MathSwipeController 

  constructor: ->
    console.log InputSolver.compute("1+2*3")
    @gridModel = new GameGrid(3)
    
    @two = new Two(
      fullscreen: true
      autostart: true
    ).appendTo(document.body);

    size = @two.height * .80
    offset = size * .025
    width = ( size - offset ) / ( @gridModel.dimension ) - offset

    boardX = ( @two.width ) / 2
    boardY = ( @two.height ) / 2
    boardY = if boardY < size / 2 then size / 2 else boardY

    board = @two.makeRectangle boardX, boardY, size, size
    board.fill = '#F0F8FF'

    @startX = boardX - (size + width) / 2
    @startY = boardY - (size + width) / 2

    @change = offset + width

    @gridView = []
    for i in [1..@gridModel.dimension]
      @gridView.push []
      for j in [1..@gridModel.dimension]
        rect = (@two.makeRectangle @getX(j), @getY(i), width, width)
        rect.fill = '#FFEBCD'
        @gridView[i-1].push rect

    @two.update()

  deleteCell: (y, x) ->
    @gridView[y][x].fill = '#FFFFFF'

  pushAllCellsToBottom: ->
    @two.update()
    for row in [@gridModel.dimension-1..1]
      for col in [@gridModel.dimension-1..0]
        if @gridView[row][col].fill is '#FFFFFF'
          for up in [row-1..0]
            unless @gridView[up][col].fill is '#FFFFFF'
              @shiftCellTo @gridView[row][col], col, up
              @shiftCellTo @gridView[up][col], col, row
              @swapView row, col, up, col
              break
    @two.update()

  shiftCellTo: (cell, x, y) ->
    cell.translation.set @getX(x) + @change, @getY(y) + @change
    @two.update()
    cell

  swapView: (r0, c0, r1, c1) ->
    temp = @gridView[r0][c0]
    @gridView[r0][c0] = @gridView[r1][c1]
    @gridView[r1][c1] = temp
    @two.update()


  getX: (colIdx) ->
    @startX + colIdx * @change

  getY: (rowIdx) ->
    @startY + rowIdx * @change

module.exports = MathSwipeController
