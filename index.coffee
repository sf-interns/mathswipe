InputSolver = require ("./app/services/InputSolver")
GameGrid    = require ("./app/models/GameGrid")
ExpressionGenerator = require ("./app/services/ExpressionGenerator")

randomInput = new ExpressionGenerator().generate 11
console.log randomInput
console.log InputSolver.compute randomInput
console.log new GameGrid 3
