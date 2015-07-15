class InputSolver
  @parseInput = (input) ->
    numberRegex = /([0-9]+|[\+\-\*])/g
    numbers = input.match numberRegex

  @isOperator = (element) ->
    return element is "+" or element is "-" or element is "*"

  @operation = (sum, element, op) ->
    if op is "+"
      sum = sum + parseInt(element)
    else if op is "-"
      sum = sum - parseInt(element)
    else if op is "*"
      sum = sum * parseInt(element)
    return sum

  @compute = (input) ->
    input = @parseInput input
    previous = input[0]
    sum = parseInt input[0]
    return NaN if isNaN sum
    for element in input
      return sum if (@isOperator previous) and (@isOperator element)
      sum = @operation sum, element, previous
      previous = element
    sum

module.exports = InputSolver