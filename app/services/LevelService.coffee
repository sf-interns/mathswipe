$ = require 'jquery'

class LevelService

  constructor: (@currLevel = 0, @numCorrect = 0, @settings) ->
    @setLevel()

  levelUp: () ->
    @currLevel++
    @setLevel()
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

  setLevel: ()->
    $("#level").text @settings.getLevelName @currLevel


module.exports = LevelService