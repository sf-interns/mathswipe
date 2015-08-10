class RunningSum

  @display: (solution, value) ->
    if isNaN value
      console.log 'invalid'
    else if @isCompleteExpression solution
      console.log (@format solution), '=', value
    else
      console.log solution

  @isCompleteExpression: (solution) ->
    for char, index in solution
      if char is '+' or char is '-' or char is '*'
        return index < solution.length - 1 and
          '0' <= solution[index + 1] and solution[index + 1] <= '9'
    false

  @format: (solution) ->
    lastOpIndex = -1
    index = 0
    while index < solution.length
      char = solution[index]
      if 3 <= index and lastOpIndex < index and (char is '+' or char is '-' or char is '*')
        first = '(' + (solution.substring 0, index) + ')'
        lastOpIndex = first.length
        solution = first + (solution.substring index)
      index++
    solution

module.exports = RunningSum
