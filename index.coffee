DFS                 = require "./app/services/DFS"
ExpressionGenerator = require "./app/services/ExpressionGenerator"
GameGrid            = require "./app/models/GameGrid"
InputSolver         = require "./app/services/InputSolver"
LastInColumn        = require "./app/services/LastInColumn"
Tuple               = require "./app/models/Tuple"
TupleSet            = require "./app/models/TupleSet"

for length in [1..30]
  expression = ExpressionGenerator.generate length
  console.log length, expression, InputSolver.compute expression

@grid = new GameGrid(4)
testGrid = new DFS @grid
stringPlacement = new TupleSet
seed = {x: 1, y: 1}
testGrid.search seed, "11+22", stringPlacement
for each in @grid.grid
  console.log each
for each in stringPlacement
  console.log each

seed = stringPlacement.list[stringPlacement.length() - 1]
console.log seed
stringPlacement = new TupleSet
testGrid.search seed, "33-44", stringPlacement
for each in @grid.grid
  console.log each

allCells = new TupleSet
for i in [0..@grid.dimension]
  for j in [0..@grid.dimension]
    allCells.push new Tuple i, j

for index in [0...allCells.length()]
  seed = allCells.at index
  stringPlacement = new TupleSet
  if testGrid.search seed, "55*667", stringPlacement
    break
console.log "\n"
for each in @grid.grid
  console.log each
