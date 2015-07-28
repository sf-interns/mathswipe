DFS                 = require "./app/services/DFS"
ExpressionGenerator = require "./app/services/ExpressionGenerator"
GameGrid            = require "./app/models/GameGrid"
InputSolver         = require "./app/services/InputSolver"
LastInColumn        = require "./app/services/LastInColumn"
Tuple               = require "./app/models/Tuple"
TupleSet            = require "./app/models/TupleSet"

# for length in [1..30]
#   expression = ExpressionGenerator.generate length
#   console.log length, expression, InputSolver.compute expression

# inputList = ["1+2-3", "45*6"]
# inputList = ["1+23"]
inputList = ["1", "22", "333",
             "4444", "55555", "666666"
             "7777777", "88888888", "999999999",
             "++++"]
@grid = new GameGrid(7)
DFS.generateBoard @grid, inputList
console.log "\n"
for each in @grid.grid
  console.log each
