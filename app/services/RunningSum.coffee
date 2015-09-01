$ = require 'jquery'

class RunningSum

  @tilesEmptyString = 'Try to get all the tiles off the board!'
  @solutionOperatorString = 'Solution must include an operator'
  @invalidString = 'Invalid Expression'
  @emptyString = ''

  @display: (solution, value) ->
    unless $('#running-sum').html() is @tilesEmptyString
      if @isSpecialString solution
        expression = solution
      else if isNaN value
        expression = @invalidString
      else if @isCompleteExpression solution
        expression = (@addParens solution) + '=' + value
      else
        expression = solution
      $('#running-sum').html(@format expression)

  @isSpecialString: (solution) ->
    strings = [@emptyString, @tilesEmptyString, @solutionOperatorString]
    strings.indexOf(solution) isnt -1

  @isCompleteExpression: (solution) ->
    return solution.search(/-?\d+[-+\*]\d+/g) is 0

  @addParens: (solution) ->
    return solution if solution.length < 3
    lastOpIndex = solution.search(/\d[-+\*]/g) + 1
    index = lastOpIndex

    while index < solution.length
      char = solution[index]
      if lastOpIndex < index and (char is '+' or char is '-' or char is '*')
        first = '(' + (solution.substring 0, index) + ')'
        lastOpIndex = first.length
        solution = first + (solution.substring index)
      index++
    solution

  @format: (input) ->
    input.replace(/\*/g, ' &times; ').replace(/\+/g, ' + ').replace(/(\d+|\))-/g, '$1 - ').replace(/\=/g, ' = ')

  @empty: -> $('#running-sum').html('')

module.exports = RunningSum
