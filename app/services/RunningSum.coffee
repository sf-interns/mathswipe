class RunningSum

  @display: (solution, value) ->
    if isNaN value
      console.log 'invalid'
    else if @isCompleteExpression solution
      console.log solution, '=', value
    else
      console.log solution

  @isCompleteExpression: (solution) ->
    for i, index in solution
      if i is '+' or i is '-' or i is '*'
        return index < solution.length - 1 and
          solution[index + 1] >= '0' and solution[index + 1] <= '9'
    false

module.exports = RunningSum
