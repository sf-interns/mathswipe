class ExpressionGenerator

  @randInclusive: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  @genRandomDigit: (min, max) ->
    @randInclusive(min, max).toString()

  @genRandomOperator: (useMult)->
    max = if useMult then 2 else 1
    switch @randInclusive 0, max
      when 0 then '+'
      when 1 then '-'
      when 2 then '*'
      else '?'

  @generate: (length, leveler) ->
    if length < 1
      throw 'Length cannot be less than 1'
    else if length is 1
      @genRandomDigit 1, 9
    else if length is 2
      (@genRandomDigit 1, 9) + (@genRandomDigit 0, 9)
    else if length is 3
      (@genRandomDigit 1, 9) +
      @genRandomOperator(leveler.settings.useMultiplication()) +
      (@genRandomDigit 1, 9)
    else
      # Pick a number between 2 and length - 1
      # _ _ _ _ _ Length is 5
      # x _ _ _ x Possible operator positions
      opIndex = (@randInclusive 2, length - 1)

      # _ O _ _ _ Assume operator at position 2
      # _ Generate an expression of length 1
      # _ _ _ Generate an expression of length 3
      # 1 (Expression) + 1 (Operator) + 3 (Expression) = 5
      (@generate opIndex - 1, leveler) +
      @genRandomOperator(leveler.settings.useMultiplication()) +
      (@generate length - opIndex, leveler)

module.exports = ExpressionGenerator
