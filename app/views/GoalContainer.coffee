$ = require 'jquery'

class GoalContainer

  # get rid of scene!!!!
  constructor: (@scene, @inputs, @symbols, @Colors) ->
    @container = $('#goals')
    @show()

  show: ->
    for goal in @inputs
      @container.append('<span class="goal-span">' + goal + '</span>')

  deleteGoal: (idx) ->
    $(@container.children()[idx]).css('color', '#2F4F4F')

  resetGoals: ->
    $(@container.children()).css('color', '#EFE8BE')

  clearGoals: ->
    @container.empty()

module.exports = GoalContainer
