class ExpressionGenerator

	randInclusive: (min, max) ->
		Math.floor(Math.random() * (max - min + 1)) + min;

	genRandomDigit: (min, max) ->
		@randInclusive(min, max).toString()

	genRandomOperator: ->
		switch @randInclusive 0, 2
			when 0 then "+"
			when 1 then "-"
			when 2 then "*"
			else "?"

	generate: (length) ->
		expression = @genRandomDigit 1, 9
		digit = true
		length--
		while length > 0
			if digit
				if (@randInclusive 0, 9) < 2
					expression += @genRandomDigit 0, 9
					length--
				if length >= 2
					expression += @genRandomOperator()
					length--
					digit = false
				else
					return expression
			else
				expression += @genRandomDigit 1, 9
				length--
				digit = true
		expression

module.exports = ExpressionGenerator
