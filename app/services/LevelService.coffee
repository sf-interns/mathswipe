class LevelService

  initialize: (@currLevel = 0, @numCorrect: 0, @settings) ->
  	return unless @settings?

  levelUp: () ->
  	@currLevel++
  	@numCorrect = 0
  	@settings.level @currLevel

  setLevel: (level) ->
  	@currLevel = level
  	@numCorrect = 0
  	@settings.level level

  checkLevelComplete: () ->
  	@levelUp() if @numCorrect is @settings.numCorrectNeeded 

module.exports = LevelController