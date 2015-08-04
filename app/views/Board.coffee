class Board

  # @boardValues is a 2D array of characters
  constructor: (@boardValues, @two, @Cell, @Colors, ClickHandler, symbols) ->
    # Unused now, but will be used for board reset
    @initialValues = @copyValues @boardValues
    @dimension = @boardValues.length or 3

    @clickHandler = new ClickHandler this, @two

    @createBoard()
    @createEmptyCells @cellWidth - 5
    @createCells @cellWidth, symbols

    @clickHandler.bindDefaultClick @board
    @clickHandler.bindClickTo @cells

    @two.update()

  createBoard: =>
    # Size is set to 80% of the height
    @size = @two.height * .80
    offset = @size * .025

    # Cell width is the width of the cell tiles
    @cellWidth = ((@size - offset) / @dimension) - offset

    # Change is used in Cell
    @change = offset + @cellWidth

    @x = @two.width / 2
    @y = @two.height / 2
    @y = if @y < @size / 2 then @size / 2 else @y

    @board = @two.makeRectangle @x, @y, @size, @size
    @board.noStroke().fill =  @Colors.board
    @board.visible = true

  createEmptyCells: (width) =>
    @empty_cells = []
    for row in [0...@dimension]
      @empty_cells.push []
      for col in [0...@dimension]
        cell = new @Cell col, row, width, @two, this
        cell.setColor @Colors.emptyCell
        cell.setBorder @Colors.emptyCellBorder
        @empty_cells[row].push cell

  createCells: (width, symbols) =>
    @cells = []
    for row in [0...@dimension]
      @cells.push []
      for col in [0...@dimension]
        cell = new @Cell col, row, width, @two, this, @clickHandler, symbols
        cell.setColor @Colors.cell
        cell.setBorder @Colors.cellBorder
        @cells[row].push cell

  deleteCells: (solution) ->
    for tuple in solution
      @deleteCellAt tuple.x, tuple.y
    @pushAllCellsToBottom()

  deleteCellAt: (x, y) ->
    @boardValues[y][x] = ' '
    @cells[y][x].delete()

  pushAllCellsToBottom: ->
    for row in [@dimension-1..1]
      for col in [@dimension-1..0]
        if @cells[row][col].isDeleted
          for up in [row-1..0]
            unless @cells[up][col].isDeleted
              @swapCells row, col, up, col
              break
    @two.update()

  swapCells: (r1, c1, r2, c2) ->
    # Move locations
    @cells[r1][c1].shiftTo r2, c2
    @cells[r2][c2].shiftTo r1, c1

    # Move the pointers
    temp = @cells[r1][c1]
    @cells[r1][c1] = @cells[r2][c2]
    @cells[r2][c2] = temp

    # Move the values
    temp = @boardValues[r1][c1]
    @boardValues[r1][c1] = @boardValues[r2][c2]
    @boardValues[r2][c2] = temp

  copyValues: (source) ->
    dest = []
    for row in [0...@dimension]
      dest.push []
      for col in [0...@dimension]
        # Q: Will it copy the pointer to the char or the char?
        dest[row].push source[row][col]
    dest

module.exports = Board
