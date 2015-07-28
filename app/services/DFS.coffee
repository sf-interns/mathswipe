AdjacentCellsCalculator = require "./AdjacentCellsCalculator"
GameGrid                = require "../models/GameGrid"
LastInColumn            = require "./LastInColumn"
Tuple                   = require "../models/Tuple"
TupleSet                = require "../models/TupleSet"

class DFS

  @shuffle: (array) ->
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

  @search: (seed, input, takenCells) ->
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

  @initializeBoard: (allCells, inputList) ->
    for i in [0...inputList.length]
      takenCells = new TupleSet
      input = inputList[i]
      hasFoundSolution = false
      for index in [0...20]
        seed = allCells[Math.floor(Math.random() * allCells.length)]
        if @search seed, input, takenCells
          hasFoundSolution = true
          break
      continue if hasFoundSolution
      return false
    true

  @generateBoard: (@grid, inputList) ->
    allCells = []
    for i in [0...@grid.dimension]
      for j in [0...@grid.dimension]
        allCells.push new Tuple i, j

    for i in [0...1000]
      break if @initializeBoard allCells, inputList
      for row in [0...@grid.dimension]
        for col in [0...@grid.dimension]
          @grid.set row, col, null
    true

module.exports = DFS
