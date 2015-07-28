AdjacentCellsCalculator = require "./AdjacentCellsCalculator"
GameGrid                = require "../models/GameGrid"
LastInColumn            = require "./LastInColumn"
Tuple                   = require "../models/Tuple"
TupleSet                = require "../models/TupleSet"

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

  search: (seed, input, takenCells) =>
    return true if input.length is 0
    toVisit = (new AdjacentCellsCalculator( @grid, null, seed.x, seed.y)).calculate(takenCells.list)
    toVisit = @shuffle toVisit
    return false if toVisit.length is 0
    curr = toVisit.shift()
    return false if (new LastInColumn).isLastAndBlocking @grid.grid, curr.x, curr.y
    while curr != undefined
      @grid.set curr.x, curr.y, input[0]
      takenCells.push new Tuple curr.x, curr.y
      solution = @search curr, input.slice(1, input.length), takenCells
      if solution
        return true
      else
        @grid.set curr.x, curr.y, null
        takenCells.pop()
        curr = toVisit.pop()
    false

module.exports = DFS
