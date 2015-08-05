class Tuple

  constructor: (@x,@y) ->

  equals: (otherTuple) =>
    return false if otherTuple is null
    @x is otherTuple.x and @y is otherTuple.y

module.exports = Tuple
