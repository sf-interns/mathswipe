$ = require 'jquery'

class GoalContainer

  constructor: (@inputs, @Colors) ->
    @container = $('#goals')
    for goal in @inputs
      @container.append('<span class="goal-span">' + goal + '</span>')

  deleteGoal: (idx) ->
    $(@container.children()[idx]).css('color', @Colors.deletedGoalGrey)

  resetGoals: ->
    $(@container.children()).css('color', @Colors.cell)

  clearGoals: ->
    @container.empty()

module.exports = GoalContainer
