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

inputList = ["1+2-3", "44*5"]
@grid = new GameGrid(3)
DFS.generateBoard @grid, inputList
console.log "\n"
for each in @grid.grid
  console.log each
