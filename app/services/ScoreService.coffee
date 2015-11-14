class ScoreService

  @score = 0

  @addToScore: (length, value) ->
    @score += length * @getDigitSum value
    console.log @score

  @getDigitSum: (value) ->
    sum = 0
    value = value.toString()
    for digit in value
      sum += parseInt digit
    sum

module.exports = ScoreService
