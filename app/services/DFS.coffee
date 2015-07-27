GameGrid                = require ("../models/GameGrid")
AdjacentCellsCalculator = require ("./AdjacentCellsCalculator")
LastInColumn            = require ("./LastInColumn")

class DFS
  constructor: (@grid) ->

  getSeed: (@grid) =>
    for i in @grid
      x = Math.floor(Math.random()*@grid.length) + 1
      y = Math.floor(Math.random()*@grid.length) + 1
      unless @grid[y][x] is null
        return [y, x]
    return false

  shuffle: (array) =>
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

  search: (seed, @grid) =>
    toVisit = @shuffle ((new AdjacentCellsCalculator( @grid, null, 0, 0)).calculate())
    curr = toVisit.pop()
    console.log curr
    checker = (new LastInColumn).isLastAndBlocking @grid.grid
    console.log checker
    curr = toVisit.pop()

module.exports = DFS
