GameGrid    = require ("./app/models/GameGrid")
InputSolver = require ("./app/services/InputSolver")
ExpressionGenerator = require("./app/services/ExpressionGenerator");

generator = new ExpressionGenerator()
for i in [1...30]
	expression = generator.generate i
	console.log i, expression, InputSolver.compute expression
