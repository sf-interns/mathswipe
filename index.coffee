GameGrid    = require ("./app/models/GameGrid")
InputSolver = require ("./app/services/InputSolver")
ExpressionGenerator = require("./app/services/ExpressionGenerator");

for length in [1..30]
  expression = ExpressionGenerator.generate length
  console.log length, expression, InputSolver.compute expression
