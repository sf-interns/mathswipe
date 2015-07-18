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

  describe '#isElementOf', ->
    tupleList = []
    tupAt = (x,y) -> new Tuple x, y
    it 'returns true when the tuple is equal to another in the list', ->
      tupleList = [(tupAt 1, 1), (tupAt 0, 0)]
      (expect (tupAt 1, 1).isElementOf tupleList).to.equal true
      (expect (tupAt 0, 0).isElementOf tupleList).to.equal true

    it 'returns false if it is not in the list', ->
      tupleList = [tupAt 1, 1,  tupAt 0, 0]
      (expect (tupAt 9, 9).isElementOf tupleList).to.equal false

    it 'returns false if the list is empty', ->
      tupleList = []
      (expect (tupAt 1, 1).isElementOf tupleList).to.equal false

    it 'returns false if the list is null', ->
      tupleList = [null, null, null]
      (expect (tupAt 1, 1).isElementOf tupleList).to.equal false
