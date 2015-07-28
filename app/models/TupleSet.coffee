class TupleSet

  constructor: (tuples=[]) ->
    @list = []
    for t in tuples
      @push t

  push: (tuple) =>
    return @list.push tuple unless tuple is null or @contains tuple

  pop: () => @list.pop()

  length: () => @list.length

  at: (idx) =>
    return @list[idx] if idx < @length()
    null

  contains: (tuple) =>
    for t in @list
      if tuple.equals t then return true
    false

module.exports = TupleSet
