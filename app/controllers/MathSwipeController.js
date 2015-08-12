// Generated by CoffeeScript 1.9.3
var $, AdjacentCellsCalculator, Board, BoardSolvedService, Cell, ClickHandler, Colors, DFS, ExpressionGenerator, GoalContainer, InputSolver, MathSwipeController, RandomizedFitLength, ResetButton, RunningSum, SolutionService, Tuple,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

AdjacentCellsCalculator = require('../services/AdjacentCellsCalculator');

BoardSolvedService = require('../services/BoardSolvedService');

ClickHandler = require('../services/ClickHandler');

DFS = require('../services/DFS');

ExpressionGenerator = require('../services/ExpressionGenerator');

InputSolver = require('../services/InputSolver');

RandomizedFitLength = require('../services/RandomizedFitLength');

ResetButton = require('../services/ResetButton');

RunningSum = require('../services/RunningSum');

SolutionService = require('../services/SolutionService');

Tuple = require('../models/Tuple');

Board = require('../views/Board');

GoalContainer = require('../views/GoalContainer');

Cell = require('../views/Cell');

Colors = require('../views/Colors');

$ = require('jquery');

MathSwipeController = (function() {
  function MathSwipeController() {
    this.testDFS = bind(this.testDFS, this);
    this.testInputSolver = bind(this.testInputSolver, this);
    this.testCellDelete = bind(this.testCellDelete, this);
    this.testExpGen = bind(this.testExpGen, this);
    this.testRandomizedFitLength = bind(this.testRandomizedFitLength, this);
    this.tests = bind(this.tests, this);
    this.gameScene = this.createGameScene();
    this.goalsScene = this.createGoalsScene();
    this.symbols = this.getSymbols();
    this.initialize();
    this.bindNewGameButton();
  }

  MathSwipeController.prototype.initialize = function() {
    var answers, expression, gameModel, i, inputLengths, inputSize, inputs, k, l, len, len1, length, value;
    length = 3;
    inputs = [];
    answers = [];
    inputLengths = RandomizedFitLength.generate(length * length);
    for (k = 0, len = inputLengths.length; k < len; k++) {
      inputSize = inputLengths[k];
      value = -1;
      while (value < 1 || value > 300) {
        expression = ExpressionGenerator.generate(inputSize);
        value = InputSolver.compute(expression);
      }
      answers.push(InputSolver.compute(expression));
      inputs.push(expression.split(''));
    }
    for (l = 0, len1 = inputs.length; l < len1; l++) {
      i = inputs[l];
      console.log(i);
    }
    console.log('\n');
    gameModel = this.generateBoard(inputs, length);
    this.goalContainer = new GoalContainer(this.goalsScene, answers, this.symbols, Colors);
    this.board = new Board(gameModel, this.gameScene, answers, this.symbols, this.goalContainer, this.isMobile().any() != null, Cell, Colors, ClickHandler, SolutionService, BoardSolvedService, RunningSum);
    this.createHowToPlay();
    return ResetButton.bindClick(this.board);
  };

  MathSwipeController.prototype.createHowToPlay = function() {
    if (this.isMobile().any() != null) {
      return $('#how-to-play').append('<b>How To Play:</b> Solve the puzzle by clearing the board. Click adjacent tiles to create an expression, and if it equals an answer, the tiles disappear!');
    } else {
      return $('#how-to-play').append('<b>How To Play:</b> Solve the puzzle by clearing the board. Drag your mouse across the tiles to create an expression, and if it equals an answer, the tiles disappear!');
    }
  };

  MathSwipeController.prototype.bindNewGameButton = function() {
    return $('#new-game-button').click((function(_this) {
      return function(e) {
        _this.gameScene.clear();
        _this.goalsScene.clear();
        ResetButton.unbindClick();
        return _this.initialize();
      };
    })(this));
  };

  MathSwipeController.prototype.createGameScene = function() {
    var gameDom, scene, size;
    gameDom = document.getElementById('game');
    size = Math.min(Math.max($(window).width(), 310), 500);
    scene = new Two({
      fullscreen: false,
      autostart: true,
      width: size,
      height: size
    }).appendTo(gameDom);
    return scene;
  };

  MathSwipeController.prototype.createGoalsScene = function() {
    var goalsDom, scene;
    goalsDom = document.getElementById('goals');
    scene = new Two({
      fullscreen: false,
      autostart: true,
      height: 100,
      width: goalsDom.clientWidth
    }).appendTo(goalsDom);
    return scene;
  };

  MathSwipeController.prototype.getSymbols = function() {
    var index, k, len, scene, svg, svgs, symbols;
    scene = new Two();
    svgs = $('#assets svg');
    symbols = [];
    for (index = k = 0, len = svgs.length; k < len; index = ++k) {
      svg = svgs[index];
      symbols.push(scene.interpret(svg));
      symbols[index].visible = false;
    }
    return symbols;
  };

  MathSwipeController.prototype.randExpression = function(length) {
    return ExpressionGenerator.generate(length);
  };

  MathSwipeController.prototype.generateInputs = function(length) {
    var i, inputs, k, ref;
    inputs = [];
    for (i = k = 0, ref = length; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      inputs.push(this.randExpression(length).split(''));
    }
    return inputs;
  };

  MathSwipeController.prototype.generateBoard = function(inputs, length) {
    return DFS.setEquationsOnGrid(length, inputs, AdjacentCellsCalculator);
  };

  MathSwipeController.prototype.isMobile = function() {
    return {
      Android: function() {
        return navigator.userAgent.match(/Android/i);
      },
      BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
      },
      iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
      },
      Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
      },
      Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
      },
      any: function() {
        return this.Android() || this.BlackBerry() || this.iOS() || this.Opera() || this.Windows();
      }
    };
  };

  MathSwipeController.prototype.tests = function() {
    this.testRandomizedFitLength();
    this.testExpGen();
    this.testInputSolver();
    return this.testDFS();
  };

  MathSwipeController.prototype.testRandomizedFitLength = function() {
    var list, size;
    size = 25;
    list = RandomizedFitLength.generate(size);
    console.log(list);
    return console.log('Passed RandomizedFitLength');
  };

  MathSwipeController.prototype.testExpGen = function() {
    var expression, k, length, results;
    results = [];
    for (length = k = 1; k <= 30; length = ++k) {
      expression = ExpressionGenerator.generate(length);
      results.push(console.log(length, expression, InputSolver.compute(expression)));
    }
    return results;
  };

  MathSwipeController.prototype.testCellDelete = function() {
    var solution;
    solution = [new Tuple(0, 0), new Tuple(1, 1), new Tuple(0, 2)];
    return this.board.deleteCells(solution);
  };

  MathSwipeController.prototype.testInputSolver = function() {
    return console.log(InputSolver.compute('1+2*3'));
  };

  MathSwipeController.prototype.testDFS = function() {
    var each, i, inputList, j, k, l, len, len1, len2, length, line, m, n, ref, ref1, results;
    length = 5;
    inputList = [];
    for (i = k = 0, ref = length; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      inputList.push((ExpressionGenerator.generate(length)).split(''));
    }
    for (l = 0, len = inputList.length; l < len; l++) {
      each = inputList[l];
      console.log(each);
    }
    console.log('\n');
    ref1 = DFS.setEquationsOnGrid(length, inputList, AdjacentCellsCalculator);
    results = [];
    for (m = 0, len1 = ref1.length; m < len1; m++) {
      each = ref1[m];
      line = '';
      for (n = 0, len2 = each.length; n < len2; n++) {
        j = each[n];
        line += j + '\t';
      }
      results.push(console.log(line));
    }
    return results;
  };

  return MathSwipeController;

})();

module.exports = MathSwipeController;
