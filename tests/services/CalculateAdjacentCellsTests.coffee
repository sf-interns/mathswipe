CalculateAdjacentCells = require "#{app_path}/services/CalculateAdjacentCells"

describe 'CalculateAdjacentCells', ->
  
  describe '#constructor', ->
    it 'attempts to find a valid location for each adjacent vertex', ->
      sinon.stub CalculateAdjacentCells.prototype, 'validLocation', ->
      service = new CalculateAdjacentCells null, [], 1, 1
      (expect service.cells.length).to.equal 8
      CalculateAdjacentCells.prototype.validLocation.restore()


  describe '#get', ->
    it 'gets the array of cells', ->
      sinon.stub CalculateAdjacentCells.prototype, 'validLocation', -> 1
      cells = new CalculateAdjacentCells null, [], 1, 1
      (expect cells.cells.length).to.equal 8
      for i in cells.cells
        (expect i).to.equal 1
      CalculateAdjacentCells.prototype.validLocation.restore()

  describe '#validLocation', ->
    grid = {at: (()->) , set: (()->), validIndices: (()->) }
    gridMock = null
    validLocation = (g, x, y) -> CalculateAdjacentCells.prototype.validLocation g, x, y 
  
    before -> sinon.stub CalculateAdjacentCells.prototype, 'checkAbove', ->
    after  -> CalculateAdjacentCells.prototype.checkAbove.restore()

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
      
