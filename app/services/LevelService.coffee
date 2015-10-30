class LevelService

  constructor: (@currLevel = 0, @numCorrect = 0, @settings) ->

  levelUp: () ->
    @currLevel++
    console.log 'Level Up!'
    @numCorrect = 0

  setLevel: (level) ->
    @currLevel = level
    @numCorrect = 0

  onCorrect: () ->
    @numCorrect++
    console.log 'Correct!', @numCorrect
    @isLevelComplete()

  isLevelComplete: () ->
    @levelUp() if @numCorrect is @settings.numCorrectNeeded @currLevel

# Settings accessors
  boardSize: () ->
    size = @settings.boardSize @currLevel
    return Number size

  multiply: () ->
    @settings.useMultiplication @currLevel

  maxGoal: () ->
    @settings.maxGoal @currLevel

module.exports = LevelService