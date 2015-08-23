class LevelService

  constructor: (@currLevel = 0, @numCorrect = 0, @settings) ->
    console.log 'LevelService'
    if @settings?
      console.log 'settings Exists', @settings
    else
      console.log 'Settings doesnt'

  levelUp: () ->
    @currLevel++
    @numCorrect = 0

  setLevel: (level) ->
    @currLevel = level
    @numCorrect = 0

  onCorrect: () ->
    @numCorrect++
    @levelUp() if @levelComplete()

  levelComplete: () ->
    @levelUp() if @numCorrect is @settings.numCorrectNeeded @currLevel

module.exports = LevelService