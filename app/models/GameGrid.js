// Generated by CoffeeScript 1.9.3
var GameGrid, GridCell,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

GridCell = require('./GridCell');

GameGrid = (function() {
  function GameGrid(dimension) {
    this.setEmpty = bind(this.setEmpty, this);
    this.isEmpty = bind(this.isEmpty, this);
    this.at = bind(this.at, this);
    this.validIndices = bind(this.validIndices, this);
    this.set = bind(this.set, this);
    var i, j, k, l, ref, ref1;
    this.grid = [];
    this.dimension = dimension;
    for (i = k = 0, ref = this.dimension; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
      this.grid.push([]);
      for (j = l = 0, ref1 = this.dimension; 0 <= ref1 ? l < ref1 : l > ref1; j = 0 <= ref1 ? ++l : --l) {
        this.grid[i].push(new GridCell);
      }
    }
  }

  GameGrid.prototype.set = function(x, y, element) {
    if (!this.validIndices(x, y)) {
      return false;
    }
    this.grid[y][x].value = element;
    return true;
  };

  GameGrid.prototype.validIndices = function(x, y) {
    return x < this.dimension && x >= 0 && y < this.dimension && y >= 0;
  };

  GameGrid.prototype.at = function(x, y) {
    if (!this.validIndices(x, y)) {
      return null;
    }
    return this.grid[y][x];
  };

  GameGrid.prototype.isEmpty = function(x, y) {
    return this.grid[y][x].isEmpty();
  };

  GameGrid.prototype.setEmpty = function(x, y) {
    return this.set(x, y, ' ');
  };

  return GameGrid;

})();

module.exports = GameGrid;
