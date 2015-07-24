Cell = require './Cell'

class Board

  constructor: (@grid, @two) ->

    @size = @two.height * .80
    offset = @size * .025
    width = ( @size - offset ) / ( @grid.dimension ) - offset

    @x = ( @two.width ) / 2
    @y = ( @two.height ) / 2
    @y = if @y < @size / 2 then @size / 2 else @y

    board = @two.makeRectangle @x, @y, @size, @size
    board.noStroke().fill =  '#c2d1e6' #'#B0C4DE' #'#F0F8FF' #'#CDE1FF'

    @change = offset + width

    cellWidth = ((@size - offset ) / @grid.dimension ) - offset

    @createEmptyCells cellWidth - 5

    @createCells cellWidth

  createEmptyCells: (width) ->
    @cells = []
    for row in [0...@grid.dimension]
      @cells.push []
      for col in [0...@grid.dimension]
        cell = new Cell col, row, width, @two, @
        cell.setColor '#b7c9e1'
        cell.setBorder '#b7c9e1'
        @cells[row].push cell

  createCells: (width) ->
    @cells = []
    for row in [0...@grid.dimension]
      @cells.push []
      for col in [0...@grid.dimension]
        cell = new Cell col, row, width, @two, @
        @cells[row].push cell

  deleteCells: (solution) ->
    for tuple in solution
      @deleteCellAt tuple.x, tuple.y
  
  deleteCellAt: (x, y) ->
    @cells[y][x].delete()
    @pushAllCellsToBottom()

  pushAllCellsToBottom: ->
    console.log @grid
    for row in [@grid.dimension-1..1]
      for col in [@grid.dimension-1..0]
        if @cells[row][col].isDeleted
          for up in [row-1..0]
            unless @cells[up][col].isDeleted
              @swapCells row, col, up, col
              break
    @two.update()

  swapCells: (r1, c1, r2, c2) ->
    # move the locations
    @cells[r1][c1].shiftTo r2, c2
    @cells[r2][c2].shiftTo r1, c1

    # move the pointers 
    temp = @cells[r1][c1]
    @cells[r1][c1] = @cells[r2][c2]
    @cells[r2][c2] = temp    

module.exports = Board
