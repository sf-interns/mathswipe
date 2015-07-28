AdjacentCellsCalculator = require ("./AdjacentCellsCalculator")
GameGrid                = require ("../models/GameGrid")
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

  search: (seed, input) =>
    return true if input.length is 0
    toVisit = (new AdjacentCellsCalculator( @grid, null, seed.x, seed.y)).calculate()
    toVisit = @shuffle toVisit
    console.log "seed = ", seed
    for each in toVisit
      console.log "toVisit = ", each
    curr = toVisit.shift()
    console.log "curr = ", curr
    checker = (new LastInColumn).isLastAndBlocking @grid.grid
    return false if checker or toVisit.length is 0
    while curr != undefined
      @grid.set curr.x, curr.y, input[0]
      for each in @grid.grid
        console.log each
      solution = @search curr, input.slice(1, input.length)
      if solution
        return true
      else
        curr = toVisit.pop()
    false

module.exports = DFS
