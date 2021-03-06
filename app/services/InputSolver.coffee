class InputSolver

  @parseInput: (input) ->
    numberRegex = /([0-9]+|[\+\-\*])/g
    numbers = input.match numberRegex

  @isOperator: (element) ->
    return element is '+' or element is '-' or element is '*'

  @operation: (sum, element, op) ->
    if op is '+' then return sum + parseInt element
    if op is '-' then return sum - parseInt element
    if op is '*' then return sum * parseInt element
    return sum

  @compute: (input) ->
    terms = @parseInput input
    previous = ''
    sum = parseInt terms[0]
    if terms[0] is '-' then sum = 0
    return NaN if (isNaN sum) and (terms[0] != '-')
    for term in terms
      return NaN if (@isOperator previous) and (@isOperator term)
      sum = @operation sum, term, previous
      previous = term
    sum

module.exports = InputSolver
