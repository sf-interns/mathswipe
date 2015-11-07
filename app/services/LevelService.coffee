$ = require 'jquery'

class LevelService

  levelDisplay: $("#level")
  levelContainer: $(".status")

  constructor: (@currLevel = 0, @numCorrect = 0, @settings) ->
    @setLevelText()

  levelUp: () ->
    @currLevel++
    # @setLevelText()
    @animate()
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

  setLevelText: ()->
    @levelDisplay.text @settings.getLevelName @currLevel

  animate:()->
    @levelDisplay.fadeOut 'linear', () =>
      @setLevelText()
    @levelDisplay.fadeIn 300, 'linear', () =>
      @levelContainer.fadeOut 'fast'
      @levelContainer.fadeIn 'fast'


module.exports = LevelService