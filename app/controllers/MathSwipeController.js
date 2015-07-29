// Generated by CoffeeScript 1.9.3
var $, Board, ExpressionGenerator, GameGrid, InputSolver, MathSwipeController, Tuple,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

InputSolver = require('../services/InputSolver');

GameGrid = require('../models/GameGrid');

ExpressionGenerator = require('../services/ExpressionGenerator');

Board = require('../views/Board');

Tuple = require('../models/Tuple');

$ = require('jQuery');

MathSwipeController = (function() {
  function MathSwipeController() {
    this.testInputSolver = bind(this.testInputSolver, this);
    this.testCellDelete = bind(this.testCellDelete, this);
    this.testExpGen = bind(this.testExpGen, this);
    this.tests = bind(this.tests, this);
    var gridModel, symbols, two;
    gridModel = new GameGrid(4);
    two = this.createTwo();
    symbols = this.getSymbols(two);
    this.board = new Board(gridModel, two);
    two.update();
    this.tests();
  }

  MathSwipeController.prototype.createTwo = function() {
    var two;
    two = new Two({
      fullscreen: true,
      autostart: true
    }).appendTo(document.getElementById('game'));
    return two;
  };

  MathSwipeController.prototype.getSymbols = function(two) {
    var i, j, len, s, svgs, symbols;
    svgs = $('#assets svg');
    symbols = [];
    for (i = j = 0, len = svgs.length; j < len; i = ++j) {
      s = svgs[i];
      symbols.push(two.interpret(s));
      symbols[i].visible = false;
    }
    return symbols;
  };

  MathSwipeController.prototype.tests = function() {
    this.testExpGen();
    this.testCellDelete();
    return this.testInputSolver();
  };

  MathSwipeController.prototype.testExpGen = function() {
    var expression, j, length, results;
    results = [];
    for (length = j = 1; j <= 30; length = ++j) {
      expression = ExpressionGenerator.generate(length);
      results.push(console.log(length, expression, InputSolver.compute(expression)));
    }
    return results;
  };

  MathSwipeController.prototype.testCellDelete = function() {
    var solution;
    solution = [new Tuple(1, 1), new Tuple(2, 2), new Tuple(3, 3)];
    return this.board.deleteCells(solution);
  };

  MathSwipeController.prototype.testInputSolver = function() {
    return console.log(InputSolver.compute("1+2*3"));
  };

  return MathSwipeController;

})();

module.exports = MathSwipeController;