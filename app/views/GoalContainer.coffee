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

  isEmpty: ->
    for goal in $(@container.children())
      return false if $(goal).css('color') isnt @Colors.deletedGoalGrey
    true

module.exports = GoalContainer
