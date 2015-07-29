// Generated by CoffeeScript 1.9.3
var AdjacentCellsCalculator, Tuple, TupleSet,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Tuple = require('../models/Tuple');

TupleSet = require('../models/TupleSet');

AdjacentCellsCalculator = (function() {
  function AdjacentCellsCalculator(grid1, cells, x1, y1) {
    this.grid = grid1;
    this.cells = cells != null ? cells : new TupleSet;
    this.x = x1;
    this.y = y1;
    this.blocked = bind(this.blocked, this);
    this.empty = bind(this.empty, this);
    this.validLocation = bind(this.validLocation, this);
    this.getToVisit = bind(this.getToVisit, this);
  }

  AdjacentCellsCalculator.prototype.getToVisit = function(takenCells) {
    var i, j, k, l, len, len1, ref, ref1, tuple;
    ref = [this.x - 1, this.x, this.x + 1];
    for (k = 0, len = ref.length; k < len; k++) {
      i = ref[k];
      ref1 = [this.y - 1, this.y, this.y + 1];
      for (l = 0, len1 = ref1.length; l < len1; l++) {
        j = ref1[l];
        if (this.blocked(i, j, takenCells) || (i === this.x && j === this.y)) {
          continue;
        }
        tuple = this.validLocation(this.grid, i, j);
        this.cells.push(tuple);
      }
    }
    return this.cells.list;
  };

  AdjacentCellsCalculator.prototype.validLocation = function(grid, x, y) {
    while (grid.validIndices(x, y)) {
      if (this.empty(grid, x, y)) {
        return new Tuple(x, y);
      }
      y--;
    }
    return null;
  };

  AdjacentCellsCalculator.prototype.empty = function(grid, x, y) {
    return (grid.at(x, y)) === ' ';
  };

  AdjacentCellsCalculator.prototype.blocked = function(x, y, takenCells) {
    var cell, k, len;
    for (k = 0, len = takenCells.length; k < len; k++) {
      cell = takenCells[k];
      if (x === cell.x && y === cell.y) {
        return true;
      }
    }
    return false;
  };

  return AdjacentCellsCalculator;

})();

module.exports = AdjacentCellsCalculator;
