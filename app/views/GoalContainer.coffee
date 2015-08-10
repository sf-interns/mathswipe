class GoalContainer

  constructor: (@scene, @inputs, @symbols, @Colors) ->
    @inputsToSymbols()
    @show()

  inputsToSymbols: ->
    @inputSymbols = []
    @count = 0
    for input, index in @inputs
      @inputSymbols.push []
      for character in input.toString()
        @inputSymbols[index].push @symbols[@charToIndex character].clone()
        @count++
      @count++
    @count--
    @inputSymbols

  show: ->
    index = 0
    symbolSize = @scene.width / @count
    for inputStr in @inputSymbols
      for character in inputStr
        character.translation.set (index * symbolSize), 0
        character.noStroke().fill = '#EFE8BE'
        character.visible = true
        character.scale = Math.min(1, (@scene.width / 100) / @count)
        index++
      index++
    @scene.update()

  charToIndex: (character) ->
    switch character
      when '+' then 10
      when '-' then 11
      when '*' then 12
      else parseInt character

  deleteGoal: (index) ->
    for character in @inputSymbols[index]
      character.noStroke().fill = '#2F4F4F'

  resetGoals: ->
    for inputStr in @inputSymbols
      for character in inputStr
        character.noStroke().fill = '#EFE8BE'

module.exports = GoalContainer
