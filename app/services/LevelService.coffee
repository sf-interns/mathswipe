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
    console.log 'Correct!'
    @isLevelComplete()

  isLevelComplete: () ->
    @levelUp() if @numCorrect is @settings.numCorrectNeeded @currLevel

# Settings accessors
  boardSize: () ->
    size = @settings.boardSize @currLevel
    console.log size
    return Number size

module.exports = LevelService