GameGrid = require "#{app_path}/models/GameGrid"

describe 'GameGrid', ->
  describe '#constructor', ->
    it 'has appropriate methods', ->
      grid = new GameGrid 3
      (expect grid).to.have.property 'at'
      (expect grid).to.have.property 'set'
      (expect grid).to.have.property 'validIndices'
      (expect grid).to.have.property 'constructor'

    it 'creates a two dimensional grid', ->
      grid = (new GameGrid 3).grid
      (expect grid).to.have.length(3)
      (expect grid[0]).to.have.length(3)

    it 'sets a dimension', ->
      dim = (new GameGrid 3).dimension
      (expect dim).to.equal 3

  describe '#at', ->
    grid = (new GameGrid 2)
    at = grid.at
    grid.grid = [[1,2],[3,4]]

    it 'returns appropriate grid access', ->
      (expect at 0, 0).to.equal 1
      (expect at 1, 0).to.equal 2
      (expect at 0, 1).to.equal 3
      (expect at 1, 1).to.equal 4

    it 'dis-allows access to improper indices', ->
      (expect at 3, 3).to.equal false
      (expect at 7, 7).to.equal false

  describe '#set', ->
    grid = new GameGrid 2
    set = grid.set
    at = grid.at

    it 'adds valid values', ->
      (expect set 0, 0, 6).to.equal true
      (expect set 0, 1, 7).to.equal true
      (expect set 1, 0, 8).to.equal true
      (expect set 1, 1, 9).to.equal true

      (expect at 0, 0).to.equal 6
      (expect at 0, 1).to.equal 7
      (expect at 1, 0).to.equal 8
      (expect at 1, 1).to.equal 9

    it 'dis-allows invalid values to be added', ->
      (expect set  2,  2).to.equal false
      (expect set 99, 99).to.equal false

  describe '#invalidIndices', ->
    valid = (new GameGrid 2).validIndices
    
    it 'allows valid values', ->
      (expect valid 0, 0).to.equal true
      (expect valid 0, 1).to.equal true
      (expect valid 1, 0).to.equal true
      (expect valid 1, 1).to.equal true

    it 'dis-allows invalid ', ->
      (expect valid  2,  2).to.equal false
      (expect valid 99, 99).to.equal false


