class LevelSettings

  @numCorrectNeeded: (level) ->
    [2,2,2,2,2,2,2][level]

  @boardSize: (level) ->
    [2,2,3,3,4,4,4][level]

  @maxGoal: (level) ->
    (level + 1) * 75

  @useMultiplication: (level) ->
    level > 2

  @getAllSettings: (level) ->
    {
      'numCorrectNeeded': @numCorrectNeeded level,
      'boardSize': @boardSize level,
      'maxGoal': @maxGoal level,
      'useMultiplication': @useMultiplication level
    }

  @getLevelName: (level)->
    ["kumkwat", "tangerine","lime","lemon","orange", "grapefruit", "blood orange"][level]


module.exports = LevelSettings