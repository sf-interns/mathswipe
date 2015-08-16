// Generated by CoffeeScript 1.9.3
var $, AdjacentCellsCalculator, Board, BoardSolvedService, Cell, ClickHandler, Colors, DFS, ExpressionGenerator, GeneralTests, GoalContainer, HowToPlay, InputSolver, MathSwipeController, RandomizedFitLength, ResetButton, RunningSum, SolutionService, Title;

$ = require('jquery');

AdjacentCellsCalculator = require('../services/AdjacentCellsCalculator');

BoardSolvedService = require('../services/BoardSolvedService');

ClickHandler = require('../services/ClickHandler');

DFS = require('../services/DFS');

ExpressionGenerator = require('../services/ExpressionGenerator');

HowToPlay = require('../services/HowToPlay');

InputSolver = require('../services/InputSolver');

RandomizedFitLength = require('../services/RandomizedFitLength');

ResetButton = require('../services/ResetButton');

RunningSum = require('../services/RunningSum');

SolutionService = require('../services/SolutionService');

Title = require('../services/Title');

Board = require('../views/Board');

Cell = require('../views/Cell');

Colors = require('../views/Colors');

GoalContainer = require('../views/GoalContainer');

GeneralTests = require('../../tests/controllers/GeneralTests');

MathSwipeController = (function() {
  function MathSwipeController() {
    this.gameScene = this.createGameScene();
    this.symbols = this.getSymbols();
    this.initialize();
    this.bindNewGameButton();
    HowToPlay.createHowToPlay(this.isMobile);
    if (this.isMobile().any() != null) {
      Title.mobileTitle();
    } else {
      this.cursorToPointer();
    }
    this.createBoard(20);
  }

  MathSwipeController.prototype.initialize = function() {
    var answers, expression, gameModel, i, inputLengths, inputs, len, length;
    length = 3;
    inputs = [];
    answers = [];
    inputLengths = RandomizedFitLength.generate(length * length);
    this.generateInputs(inputLengths, inputs, answers);
    for (i = 0, len = inputs.length; i < len; i++) {
      expression = inputs[i];
      console.log(expression);
    }
    console.log('\n');
    gameModel = this.generateBoard(inputs, length);
    this.goalContainer = new GoalContainer(answers, Colors);
    this.board = new Board(gameModel, this.gameScene, answers, this.symbols, this.goalContainer, this.isMobile().any() != null, Cell, Colors, ClickHandler, SolutionService, BoardSolvedService, RunningSum);
    return ResetButton.bindClick(this.board);
  };

  MathSwipeController.prototype.createBoard = function(numRowCells) {
    var col, gridCell, gridElem, gridRow, i, ref, results, row;
    this.setGridStyling(numRowCells);
    gridElem = $('#grid-container');
    results = [];
    for (row = i = 0, ref = numRowCells; 0 <= ref ? i < ref : i > ref; row = 0 <= ref ? ++i : --i) {
      gridRow = '<div id="grid-row-' + row + '" class="grid-row"></div>';
      gridElem.append(gridRow);
      results.push((function() {
        var j, ref1, results1;
        results1 = [];
        for (col = j = 0, ref1 = numRowCells; 0 <= ref1 ? j < ref1 : j > ref1; col = 0 <= ref1 ? ++j : --j) {
          gridCell = '<div id="grid-cell-' + row + '-' + col + '" class="grid-cell"></div>';
          $('#grid-row-' + row).append(gridCell);
          results1.push($('#grid-cell-' + row + '-' + col).css(this.gridCellStyle));
        }
        return results1;
      }).call(this));
    }
    return results;
  };

  MathSwipeController.prototype.setGridStyling = function(numRowCells) {
    var fieldWidth, gridSpacing, tileSize;
    gridSpacing = 15;
    fieldWidth = Math.min(Math.max($(window).width(), 310), 500);
    tileSize = (fieldWidth - gridSpacing * (numRowCells + 1)) / numRowCells;
    return this.gridCellStyle = {
      width: tileSize,
      height: tileSize
    };
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

  MathSwipeController.prototype.bindNewGameButton = function() {
    return $('#new-game-button').click((function(_this) {
      return function(e) {
        _this.gameScene.clear();
        _this.goalContainer.clearGoals();
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
    var goalsDom;
    return goalsDom = document.getElementById('goals');
  };

  MathSwipeController.prototype.cursorToPointer = function() {
    $('#game').addClass('pointer');
    return $('#game-button-wrapper').addClass('pointer');
  };

  MathSwipeController.prototype.getSymbols = function() {
    var i, index, len, scene, svg, svgs, symbols;
    scene = new Two();
    svgs = $('#assets svg');
    symbols = [];
    for (index = i = 0, len = svgs.length; i < len; index = ++i) {
      svg = svgs[index];
      symbols.push(scene.interpret(svg));
      symbols[index].visible = false;
    }
    return symbols;
  };

  MathSwipeController.prototype.generateBoard = function(inputs, length) {
    return DFS.setEquationsOnGrid(length, inputs, AdjacentCellsCalculator);
  };

  MathSwipeController.prototype.generateInputs = function(inputLengths, inputs, answers) {
    var expression, i, inputSize, len, results, value;
    results = [];
    for (i = 0, len = inputLengths.length; i < len; i++) {
      inputSize = inputLengths[i];
      value = -1;
      while (value < 1 || value > 300) {
        expression = ExpressionGenerator.generate(inputSize);
        value = InputSolver.compute(expression);
      }
      answers.push(InputSolver.compute(expression));
      results.push(inputs.push(expression.split('')));
    }
    return results;
  };

  MathSwipeController.prototype.randExpression = function(length) {
    return ExpressionGenerator.generate(length);
  };

  return MathSwipeController;

})();

module.exports = MathSwipeController;
