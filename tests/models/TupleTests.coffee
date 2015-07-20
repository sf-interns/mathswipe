Tuple = require "#{app_path}/models/Tuple"
GameGrid = require "#{app_path}/models/GameGrid"

describe 'Tuple', ->
  tupAt = (x,y) -> new Tuple x, y

  describe '#constructor', ->
    tuple = new Tuple 1, -1
    it 'initilizes inputs as get-table fields', ->
      (expect tuple.x).to.equal 1
      (expect tuple.y).to.equal -1

  describe '#equals', ->
    it 'returns true when same co-ordinates are equal', ->
      (expect (tupAt 1, 1).equals tupAt 1, 1).to.equal true

    it 'returns false when one coordinate is different', ->
      (expect (tupAt 1, 0).equals tupAt 1, 1 ).to.equal false
      (expect (tupAt 1, 1).equals tupAt 1, 0 ).to.equal false
      (expect (tupAt 1, 1).equals tupAt 0, 1 ).to.equal false
      (expect (tupAt 0, 1).equals tupAt 1, 1 ).to.equal false

    it 'returns false when both coordinates are different', ->
      (expect (tupAt 1, 1).equals(tupAt 0, 0)).to.equal false

