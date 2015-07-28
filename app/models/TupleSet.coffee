class TupleSet

  constructor: (tuples=[]) ->
    @set = []
    for t in tuples
      @push t

  push: (tuple) =>
    return @set.push tuple unless tuple is null or @contains tuple

  pop: () => @set.pop()

  length: () => @set.length

  at: (idx) =>
    return @set[idx] if idx < @length() 
    null

  contains: (tuple) =>
    for t in @set
      if tuple.equals t then return true
    false

module.exports = TupleSet
