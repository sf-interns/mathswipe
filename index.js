// Generated by CoffeeScript 1.9.3
var ExpressionGenerator, GameGrid, InputSolver, expression, i, length;

GameGrid = require("./app/models/GameGrid");

InputSolver = require("./app/services/InputSolver");

ExpressionGenerator = require("./app/services/ExpressionGenerator");

for (length = i = 1; i <= 30; length = ++i) {
  expression = ExpressionGenerator.generate(length);
  console.log(length, expression, InputSolver.compute(expression));
}
