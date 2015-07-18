TupleSet = require "#{app_path}/models/TupleSet"

describe 'TupleSet', ->
  describe '#constructor', ->
    it 'given unique list, adds each element', ->
      tuple1 = {isElementOf: ()->}
      tuple2 = {isElementOf: ()->}

      sinon.stub tuple1, 'isElementOf', -> false
      sinon.stub tuple2, 'isElementOf', -> false

      list = [tuple1,tuple2]
      set = new TupleSet list

      (expect set.length()).to.equal 2

    it 'given not-unique list, gives uniquified list', ->
      tuples =  [ { isElementOf: ()-> } ]
      tuples.push { isElementOf: ()-> }
      tuples.push { isElementOf: ()-> }
      tuples.push { isElementOf: ()-> }

      sinon.stub tuples[0], 'isElementOf', -> false
      sinon.stub tuples[1], 'isElementOf', -> false

      sinon.stub tuples[2], 'isElementOf', -> true
      sinon.stub tuples[3], 'isElementOf', -> true

      set = new TupleSet tuples

      (expect set.set.length).to.equal 2


    it 'given not-unique list, gives uniquified list', ->
      tuples =  [ { isElementOf: ()-> } ]
      tuples.push { isElementOf: ()-> }
      tuples.push { isElementOf: ()-> }
      tuples.push { isElementOf: ()-> }

      sinon.stub tuples[0], 'isElementOf', -> false
      sinon.stub tuples[1], 'isElementOf', -> false

      sinon.stub tuples[2], 'isElementOf', -> true
      sinon.stub tuples[3], 'isElementOf', -> true

      set = new TupleSet tuples

      (expect set.set.length).to.equal 2


    it 'given no parameters, gives empty list', ->
      (expect (new TupleSet).length()).to.equal 0     

  describe '#push', ->
    it 'adds unique non-null elements to the set', ->
      set = new TupleSet
      set.push { isElementOf: (t) -> false }
      (expect set.set.length).to.equal 1

    it 'doesnt add null elements', ->      
      set = new TupleSet
      set.push null
      (expect set.set.length).to.equal 0

    it 'doesnt add duplicate elements', ->
      set = new TupleSet
      set.push { isElementOf: (t) -> true }
      (expect set.set.length).to.equal 0


  describe '#pop', ->
    it 'removes the last element', ->
      set = new TupleSet
      set.set = ['a','b']
      (expect set.pop()).to.equal 'b'


  describe '#length', ->
    it 'gives the length of the set', ->
      set = new TupleSet [ { isElementOf: (t) -> false }, { isElementOf: (t) -> false}]
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



