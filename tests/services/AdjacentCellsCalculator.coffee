AdjacentCellsCalculator = require "#{app_path}/services/AdjacentCellsCalculator"

describe 'AdjacentCellsCalculator', ->
  
  describe '#constructor', ->
    before -> sinon.stub AdjacentCellsCalculator.prototype, 'validLocation', ->
    after  -> AdjacentCellsCalculator.prototype.restore()

    it 'attempts to find a valid location for each adjacent vertex', ->
      grid = [[1,2],[3,4]]
      cells = [1,2,3,4]
      service = new AdjacentCellsCalculator grid, cells, 1, 1
      (expect service.grid).to.equal grid
      (expect service.cells).to.equal cells
      (expect service.x).to.equal 1
      (expect service.y).to.equal 2


  describe '#get', ->
    before -> sinon.stub AdjacentCellsCalculator.prototype, 'validLocation', -> 1
    after  -> AdjacentCellsCalculator.prototype.restore()

    it 'gets the array of cells', ->
      cells = new AdjacentCellsCalculator null, [], 1, 1
      (expect cells.cells.length).to.equal 8
      for i in cells.cells
        (expect i).to.equal 1

  describe '#validLocation', ->
    grid          = {at: (()->) , set: (()->), validIndices: (()->) }
    gridMock      = null
    validLocation = AdjacentCellsCalculator.prototype.validLocation
  
    before -> sinon.stub AdjacentCellsCalculator.prototype, 'checkAbove', ->
    after  -> AdjacentCellsCalculator.prototype.checkAbove.restore()

    beforeEach =>  gridMock = sinon.mock(grid)
    afterEach => gridMock.restore()

    it 'returns null if the vertices are invalid', =>
      gridMock.expects('at').once().returns false
      
      (expect ( validLocation grid, 1, 1)).to.equal null
      gridMock.verify()

    it 'returns a tuple if the location is empty', =>
      (gridMock.expects 'at').once().returns null

      result = validLocation grid, 1, 2

      (expect result.x).to.equal 1
      (expect result.y).to.equal 2
      gridMock.verify()
      
