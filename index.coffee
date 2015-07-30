AdjacentCellsCalculator = require './app/services/AdjacentCellsCalculator'
DFS                     = require './app/services/DFS'
ExpressionGenerator     = require './app/services/ExpressionGenerator'
GameGrid                = require './app/models/GameGrid'
InputSolver             = require './app/services/InputSolver'
Tuple                   = require './app/models/Tuple'

# for length in [1..30]
#   expression = ExpressionGenerator.generate length
#   console.log length, expression, InputSolver.compute expression

# inputList = ['1+2-3', '45*6']
# inputList = ['1234']
# inputList = ['1', '22', '333',
#              '4444', '55555', '666666'
#              '7777777', '88888888', '999999999',
#              '++++']
inputList = ["1111", "2222",
             "3333", "4444"]

@grid = new GameGrid(4)
DFS.setEquationsOnGrid @grid, inputList, AdjacentCellsCalculator
console.log '\n'
for each in @grid.grid
  line = ''
  for j in each
    line += j.value + '\t'
  console.log line
for each in DFS.inputTupleLists
  console.log each
