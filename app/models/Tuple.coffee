class Tuple

  constructor: (@x,@y) ->

  equals: (otherTuple) =>
    return false if otherTuple is null
    @x is otherTuple.x and @y is otherTuple.y

  isElementOf: (tuples) =>
    for t in tuples
      if @equals(t) then return true
    false

module.exports = Tuple
