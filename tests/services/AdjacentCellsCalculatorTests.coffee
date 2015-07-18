AdjacentCellsCalculator = require "#{app_path}/services/AdjacentCellsCalculator"

describe 'AdjacentCellsCalculator', ->
  
  describe '#constructor', ->
    before => sinon.stub AdjacentCellsCalculator.prototype, 'validLocation', ->
    after  => AdjacentCellsCalculator.prototype.validLocation.restore()

    it 'attempts to find a valid location for each adjacent vertex', ->
      grid = [[1,2],[3,4]]
      cells = [1,2,3,4]
      service = new AdjacentCellsCalculator grid, cells, 1, 2
      (expect service.grid).to.equal grid
      (expect service.cells).to.equal cells
      (expect service.x).to.equal 1
      (expect service.y).to.equal 2


  describe '#calculate', ->
    before => sinon.stub AdjacentCellsCalculator.prototype, 'validLocation', -> 1
    after  => AdjacentCellsCalculator.prototype.validLocation.restore()

    it 'gets the array of cells', ->
      cells = new AdjacentCellsCalculator null, [], 1, 1
      cells.calculate()
      (expect cells.cells.length).to.equal 8
      for i in cells.cells
        (expect i).to.equal 1

  describe '#validLocation', ->
    grid         = {at: (()->) , set: (()->), validIndices: (()->) }
    gridMock     = null

    before => 
      sinon.stub AdjacentCellsCalculator.prototype, 'checkAbove', -> 'checkAbove called'
    after  => 
      AdjacentCellsCalculator.prototype.checkAbove.restore()

    beforeEach =>  gridMock = sinon.mock(grid)
    afterEach => gridMock.restore()

    it 'returns null if the vertices are invalid', =>
      gridMock.expects('at').once().returns false
      
      result = AdjacentCellsCalculator.prototype.validLocation grid, 1, 1

      (expect result).to.equal null
      gridMock.verify()

    it 'returns a tuple if the location is empty', =>
      (gridMock.expects 'at').once().returns null

      result = AdjacentCellsCalculator.prototype.validLocation grid, 1, 2

      (expect result.x).to.equal 1
      (expect result.y).to.equal 2
      gridMock.verify()

    it 'checks above if the vertex is taken', =>
      (gridMock.expects 'at').once().returns '7'
      result = AdjacentCellsCalculator.prototype.validLocation grid, 1, 2
      
      (expect result).to.equal 'checkAbove called'
      gridMock.verify()
      
