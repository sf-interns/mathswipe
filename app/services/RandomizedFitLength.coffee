class RandomizedFitLength

  @randInclusive: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  @generate: (size, list=[]) ->
    return list if size is 0
    length = @randInclusive 3, 5
    if size - length < 0 and list.length != 0
      @generate size + list.pop(), list
    else
      list.push length
      @generate size - length, list

module.exports = RandomizedFitLength
