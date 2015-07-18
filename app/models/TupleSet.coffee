class TupleSet

  constructor: (tuples=[]) ->
    @set = []
    for t in tuples
      @push t

  push: (tuple) =>
    @set.push tuple unless tuple is null or tuple.isElementOf @set

  pop: () =>
    @set.pop()

  length: () =>
    @set.length

  at: (idx)=>
    return @set[idx] if idx < @length() 
    false

module.exports = TupleSet
