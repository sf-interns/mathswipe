class Board

  # @boardValues is a 2D array of characters
  constructor: (@boardValues, @scene, @goals, @symbols, @goalContainer, @Cell, @Colors, @ClickHandler, @SolutionService, @BoardSolvedService) ->
    @dimension = @boardValues.length
    @initialValues = @copyValues @boardValues
    @initializer()
    @getSuccessSVG()

  initializer: =>
    solutionService = new @SolutionService this, @goals
    @clickHandler = new @ClickHandler this, @two, solutionService, @goalContainer, @BoardSolvedService

    @createBoard()
    @createEmptyCells @cellWidth - 5
    @createCells @cellWidth

    @clickHandler.bindDefaultClick @board
    @clickHandler.bindClickTo @cells

    @scene.update()

  createBoard: =>
    # Size is set to 95% of the height
    @size = @scene.height * .95
    offset = @size * .025

    # Cell width is the width of the cell tiles
    @cellWidth = ((@size - offset) / @dimension) - offset

    # Change is used in Cell
    @change = offset + @cellWidth

    @x = @scene.width / 2
    @y = @scene.height / 2
    @y = if @y < @size / 2 then @size / 2 else @y

    @board = @scene.makeRectangle @x, @y, @size, @size
    @board.noStroke().fill =  @Colors.board
    @board.visible = true

  createEmptyCells: (width) =>
    @empty_cells = []
    for row in [0...@dimension]
      @empty_cells.push []
      for col in [0...@dimension]
        cell = new @Cell col, row, width, @scene, this
        cell.setColor @Colors.emptyCell
        cell.setBorder @Colors.emptyCellBorder
        @empty_cells[row].push cell

  createCells: (width) =>
    @cells = []
    for row in [0...@dimension]
      @cells.push []
      for col in [0...@dimension]
        cell = new @Cell col, row, width, @scene, this, @clickHandler, @symbols[@toIdx @boardValues[row][col]]
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
    @scene.update()

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

  toIdx: (val) ->
    return null unless val.length is 1
    switch val
      when '+' then 10
      when '-' then 11
      when '*' then 12
      else return parseInt val

  copyValues: (source) ->
    dest = []
    for row in [0...@dimension]
      dest.push []
      for col in [0...@dimension]
        dest[row].push source[row][col]
    dest

  resetBoard: ->
    @boardValues = @copyValues @initialValues
    @goalContainer.resetGoals()
    @initializer()

  getSuccessSVG: ->
    @successSVG = @symbols[@symbols.length - 1].clone()
    @successSVG.noStroke().fill = '#D1857F'

  successAnimation: ->
    @scene.add @successSVG
    @scene.update()

module.exports = Board
