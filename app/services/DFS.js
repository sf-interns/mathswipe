// Generated by CoffeeScript 1.9.3
var AdjacentCellsCalculator, DFS, GameGrid, LastInColumn, Tuple, TupleSet;

AdjacentCellsCalculator = require("./AdjacentCellsCalculator");

GameGrid = require("../models/GameGrid");

LastInColumn = require("./LastInColumn");

Tuple = require("../models/Tuple");

TupleSet = require("../models/TupleSet");

DFS = (function() {
  function DFS() {}

  DFS.shuffle = function(array) {
    var i, m, t;
    m = array.length;
    t = void 0;
    i = void 0;
    while (m) {
      i = Math.floor(Math.random() * m--);
      t = array[m];
      array[m] = array[i];
      array[i] = t;
    }
    return array;
  };

  DFS.search = function(seed, input, takenCells) {
    var curr, solution, toVisit;
    if (input.length === 0) {
      return true;
    }
    toVisit = new AdjacentCellsCalculator(this.grid, null, seed.x, seed.y);
    toVisit = this.shuffle(toVisit.calculate(takenCells.list));
    if (toVisit.length === 0) {
      return false;
    }
    curr = toVisit.shift();
    if ((new LastInColumn).isLastAndBlocking(this.grid.grid, curr.x, curr.y)) {
      return false;
    }
    while (curr !== void 0) {
      this.grid.set(curr.x, curr.y, input[0]);
      takenCells.push(new Tuple(curr.x, curr.y));
      solution = this.search(curr, input.slice(1, input.length), takenCells);
      if (solution) {
        return true;
      } else {
        this.grid.set(curr.x, curr.y, " ");
        takenCells.pop();
        curr = toVisit.pop();
      }
    }
    return false;
  };

  DFS.initializeBoard = function(allCells, inputList) {
    var hasFoundSolution, i, index, input, k, l, ref, seed, takenCells;
    for (i = k = 0, ref = inputList.length; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      takenCells = new TupleSet;
      input = inputList[i];
      hasFoundSolution = false;
      for (index = l = 0; l < 20; index = ++l) {
        seed = allCells[Math.floor(Math.random() * allCells.length)];
        if (this.search(seed, input, takenCells)) {
          hasFoundSolution = true;
          break;
        }
      }
      if (hasFoundSolution) {
        continue;
      }
      return false;
    }
    return true;
  };

  DFS.generateBoard = function(grid, inputList) {
    var allCells, col, i, j, k, l, n, o, p, ref, ref1, ref2, ref3, row;
    this.grid = grid;
    allCells = [];
    for (i = k = 0, ref = this.grid.dimension; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      for (j = l = 0, ref1 = this.grid.dimension; 0 <= ref1 ? l < ref1 : l > ref1; j = 0 <= ref1 ? ++l : --l) {
        allCells.push(new Tuple(i, j));
      }
    }
    for (i = n = 0; n < 1000; i = ++n) {
      if (this.initializeBoard(allCells, inputList)) {
        break;
      }
      for (row = o = 0, ref2 = this.grid.dimension; 0 <= ref2 ? o < ref2 : o > ref2; row = 0 <= ref2 ? ++o : --o) {
        for (col = p = 0, ref3 = this.grid.dimension; 0 <= ref3 ? p < ref3 : p > ref3; col = 0 <= ref3 ? ++p : --p) {
          this.grid.set(row, col, " ");
        }
      }
    }
    return true;
  };

  return DFS;

})();

module.exports = DFS;
