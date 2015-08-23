class LevelSettings

  @numCorrectNeeded: (level) ->
    [5,5,5,4,3,3,2][level]

  @boardSize: (level) ->
    [2,2,3,3,4,4,4][level]

  @maxGoal: (level) ->
    level * 75

  @numGoals: (level) ->
    [1,1,3,2,4,3,1][level]

  @useMultiplication: (level) ->
    level > 2

  @getAllSettings: (level) ->
    {
      'numCorrectNeeded': @numCorrectNeeded level,
      'boardSize': @boardSize level,
      'maxGoal': @maxGoal level,
      'numGoals': @numGoals level,
      'useMultiplication': @useMultiplication level
    }


module.exports = LevelSettings