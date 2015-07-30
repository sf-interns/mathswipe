AdjacentCellsCalculator = require './app/services/AdjacentCellsCalculator'
DFS                     = require './app/services/DFS'
ExpressionGenerator     = require './app/services/ExpressionGenerator'
GameGrid                = require './app/models/GameGrid'
InputSolver             = require './app/services/InputSolver'
Tuple                   = require './app/models/Tuple'
TupleSet                = require './app/models/TupleSet'

# for length in [1..30]
#   expression = ExpressionGenerator.generate length
#   console.log length, expression, InputSolver.compute expression

# inputList = ['1+2-3', '45*6']
# inputList = ['1234']
# inputList = ['1', '22', '333',
#              '4444', '55555', '666666'
#              '7777777', '88888888', '999999999',
#              '++++']
inputList = ["1111111", "2222222",
             "3333333", "4444444",
             "5555555", "6666666",
             "7777777" ]
@grid = new GameGrid(7)
DFS.setEquationsOnGrid @grid, inputList, AdjacentCellsCalculator
console.log '\n'
for each in @grid.grid
  console.log each
