$ = require 'jquery'

class RunningSum

  @display: (solution, value) ->
    if isNaN value
      expression = 'invalid'
    else if @isCompleteExpression solution
      expression = (@addParens solution) + '=' + value
    else
      expression = solution
    $('#running-sum').html(@format expression)

  @isCompleteExpression: (solution) ->
    for char, index in solution
      if char is '+' or char is '-' or char is '*'
        return index < solution.length - 1 and
          '0' <= solution[index + 1] and solution[index + 1] <= '9'
    false

  @addParens: (solution) ->
    return solution if solution.length < 3
    lastOpIndex = -1
    index = 2
    while index < solution.length
      char = solution[index]
      if lastOpIndex < index and (char is '+' or char is '-' or char is '*')
        first = '(' + (solution.substring 0, index) + ')'
        lastOpIndex = first.length
        solution = first + (solution.substring index)
      index++
    solution

  @format: (input) ->
    input.replace(/\*/g, " &times; ").replace(/\+/g, " + ").replace(/\-/g, " - ").replace(/\=/g, " = ")

module.exports = RunningSum
