GameGrid = require ("../models/GameGrid")
AdjacentCellsCalculator = require("./AdjacentCellsCalculator")

class DFS
  getSeed = (grid) ->
    for i in @grid
      x = Math.floor(Math.random()*@grid.length) + 1
      y = Math.floor(Math.random()*@grid.length) + 1
      unless @grid[y][x] is null
        return [y, x]
    return false

  shuffle = (array) ->
    # Fisher-Yates shuffle
    m = array.length
    t = undefined
    i = undefined
    # While there remain elements to shuffle…
    while m
      # Pick a remaining element…
      i = Math.floor(Math.random() * m--)
      # And swap it with the current element.
      t = array[m]
      array[m] = array[i]
      array[i] = t
    array

  # @DFS = (input, @grid, x, y, isFirst) ->
  #   if input.length is 0
  #     return @grid
  #   if isFirst
  #     seed = @getSeed
  #     return false if Seed is false
  #     @grid[seed.y][seed.x] = input.charAt 0
  #     @DFS input.substr(1), @grid, seed.x, seed.y false

  #     # @shuffle AdjacentCellsCalculator.(x, y)

  DFS = (seed) ->
    toVisit = shuffle ((new AdjacentCellsCalculator( new GameGrid(3), null, 1, 1)).calculate())
    console.log toVisit

module.exports = DFS
