TupleSet = require '#{app_path}/models/TupleSet'
Tuple    = require '#{app_path}/models/Tuple'

describe 'TupleSet', ->
  describe '#constructor', ->
    it 'given unique list, adds each element', ->
      tuple1 = sinon.createStubInstance Tuple
      tuple2 = sinon.createStubInstance Tuple

      sinon.stub TupleSet.prototype, 'contains', -> false

      list = [tuple1,tuple2]
      set = new TupleSet list

      (expect set.length()).to.equal 2

      TupleSet.prototype.contains.restore()

    it 'given not-unique list, gives uniquified list', ->
      tuples =  [ sinon.createStubInstance Tuple ]
      tuples.push sinon.createStubInstance Tuple
      tuples.push sinon.createStubInstance Tuple
      tuples.push sinon.createStubInstance Tuple

      containsStub = sinon.stub TupleSet.prototype, 'contains'

      containsStub.onCall(0).returns false
      containsStub.onCall(1).returns false
      containsStub.onCall(2).returns true
      containsStub.onCall(3).returns true

      set = new TupleSet tuples

      (expect set.set.length).to.equal 2

      TupleSet.prototype.contains.restore()


    it 'given no parameters, gives empty list', ->
      (expect (new TupleSet).set.length).to.equal 0

  describe '#push', ->
    it 'adds unique non-null elements to the set', ->
      sinon.stub TupleSet.prototype, 'contains', -> false
      set = new TupleSet
      set.push sinon.createStubInstance Tuple
      (expect set.set.length).to.equal 1
      TupleSet.prototype.contains.restore()

    it 'doesnt add null elements', ->
      set = new TupleSet
      set.push null
      (expect set.set.length).to.equal 0

    it 'doesnt add duplicate elements', ->
      sinon.stub TupleSet.prototype, 'contains', -> true
      set = new TupleSet
      set.push sinon.createStubInstance Tuple
      (expect set.set.length).to.equal 0
      TupleSet.prototype.contains.restore()


  describe '#pop', ->
    it 'removes the last element', ->
      set = new TupleSet
      set.set = ['a','b']
      (expect set.pop()).to.equal 'b'


  describe '#length', ->
    it 'gives the length of the set', ->
      set = new TupleSet []
      set.set = [1, 1]
      (expect set.length()).to.equal 2

  describe '#at', ->

    it 'returns value at valid index', ->
      tSet = new TupleSet []
      tSet.set = ['a', 'b', 'c']
      (expect tSet.at 0).to.equal 'a'
      (expect tSet.at 1).to.equal 'b'
      (expect tSet.at 2).to.equal 'c'

    it 'returns false if index is invalid', ->
      tSet = new TupleSet []
      tSet.set = ['a', 'b', 'c']
      (expect tSet.at 3).to.equal false
      (expect tSet.at 99).to.equal false

  describe '#contains', ->
    set = (arr) -> new TupleSet arr
    tupAt = (x,y) -> new Tuple x, y
    it 'returns true when the tuple is equal to another in the list', ->
      tupleSet = set [(tupAt 1, 1), (tupAt 0, 0)]
      (expect tupleSet.contains tupAt 1, 1).to.equal true
      (expect tupleSet.contains tupAt 0, 0).to.equal true

    it 'returns false if it is not in the list', ->
      tupleSet = set [tupAt 1, 1,  tupAt 0, 0]
      (expect tupleSet.contains tupAt 9, 9).to.equal false

    it 'returns false if the list is empty', ->
      tupleSet = set []
      (expect tupleSet.contains tupAt 1, 1).to.equal false

    it 'returns false if the list is null', ->
      tupleSet = set [null, null, null]
      (expect tupleSet.contains tupAt 1, 1).to.equal false
