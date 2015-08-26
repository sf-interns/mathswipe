$ = require 'jquery'

class Board

  # @boardValues is a 2D array of characters
  constructor: (@boardValues, @goals, @goalContainer, @isMobile, @Cell, @Colors, @ClickHandler, @SolutionService, @BoardSolvedService, @RunningSum) ->
    @dimension = @boardValues.length
    @initialValues = @copyValues @boardValues
    @initializer()


# --------------jquery------------- #
  createBoard: ->
    gridElem = $('#grid-container')
    for row in [0...@dimension]
      gridRow = '<div id="grid-row-' + row + '" class="grid-row"></div>'
      gridElem.append(gridRow)
      for col in [0...@dimension]
        gridCell = '<div id="grid-cell-' + row + '-' + col + '" class="grid-cell"></div>'
        $('#grid-row-' + row).append(gridCell)
        $('#grid-cell-' + row + '-' + col).css(@gridCellStyle)

    @createCells @dimension
    # @setDistance()

  setGridStyling: ->
    gridSpacing = 15
    fieldWidth = Math.min(Math.max($( window ).width(), 310), 500)
    tileSize = (fieldWidth - gridSpacing * (@dimension + 1)) / @dimension
    @gridCellStyle = { width: tileSize, height: tileSize, "line-height": "#{tileSize}px" }
    $('#game-container').css({ width: fieldWidth, height: fieldWidth })

  bindCellsClick: ->
    for row in [0...@dimension]
      for col in [0...@dimension]
        $('#cell-' + row + '-' + col).click (e) =>
          e.preventDefault()
          num = 2
          distance = num * @dropDownDistance
          # $(e.currentTarget).css( "transform", "translate(0, #{distance}px)" )
          $(e.currentTarget).css( "color", "blue" )
          console.log $(e.currentTarget).text()

  createCells: ->
    @cells = []
    containerElem = $('#cell-container')
    for row in [0...@dimension]
      @cells.push []
      cellRow = '<div id="cell-row-' + row + '" class="cell-row"></div>'
      containerElem.append(cellRow)
      for col in [0...@dimension]
        cell = new @Cell col, row, this, @clickHandler, @boardValues[row][col], @gridCellStyle
        @cells[row].push cell


  clearBoardElem: ->
    $('#grid-container').empty()
    $('#cell-container').empty()
# --------------jquery------------- #

  initializer: =>
    solutionService = new @SolutionService this, @goals
    @clickHandler = new @ClickHandler this, solutionService, @goalContainer, @isMobile, @BoardSolvedService, @RunningSum



    @setGridStyling()
    @createBoard()
    # @bindCellsClick()




    @clickHandler.bindDefaultMouseEvents()


  createEmptyCells: (width) =>
    @empty_cells = []
    for row in [0...@dimension]
      @empty_cells.push []
      for col in [0...@dimension]
        cell = new @Cell col, row, width, @scene, this
        cell.setColor @Colors.emptyCell
        cell.setBorder @Colors.emptyCellBorder
        @empty_cells[row].push cell

  # createCells: (size) =>
  #   @cells = []
  #   for row in [0...@dimension]
  #     @cells.push []
  #     for col in [0...@dimension]
  #       cell = new @Cell col, row, size, @scene, this, @clickHandler, @symbols[@toIdx @boardValues[row][col]]
  #       cell.setColor @Colors.cell
  #       cell.setBorder @Colors.cellBorder
  #       @cells[row].push cell

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

  copyValues: (source) ->
    dest = []
    for row in [0...@dimension]
      dest.push []
      for col in [0...@dimension]
        dest[row].push source[row][col]
    dest

  resetBoard: ->
    @clearBoardElem()
    @boardValues = @copyValues @initialValues
    @goalContainer.resetGoals()
    @initializer()

module.exports = Board
