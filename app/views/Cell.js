// Generated by CoffeeScript 1.9.3
var $, Cell, Colors;

$ = require('jquery');

Colors = require('./colors');

Cell = (function() {
  function Cell(col1, row1, size, two, board, clickHandler, symbols) {
    this.col = col1;
    this.row = row1;
    this.size = size;
    this.two = two;
    this.board = board;
    this.clickHandler = clickHandler;
    this.isDeleted = false;
    this.isSelected = false;
    this.rect = this.two.makeRectangle(this.getX(), this.getY(), this.size, this.size);
    if (symbols != null) {
      this.cell = this.two.makeGroup(this.rect, this.newSymbol(symbols, 8));
    } else {
      this.cell = this.two.makeGroup(this.rect);
    }
    this.two.update();
  }

  Cell.prototype.newSymbol = function(symbols, value) {
    var symbol;
    symbol = symbols[value].clone();
    symbol.translation.set(this.getX() - 0.4 * this.size, this.getY() - 0.4 * this.size);
    symbol.scale = (this.size / 480) * .8;
    symbol.fill = 'black';
    return symbol;
  };

  Cell.prototype.setColor = function(c) {
    this.color = c;
    this.rect.fill = c;
    return this.two.update();
  };

  Cell.prototype.setBorder = function(c) {
    this.rect.stroke = c;
    this.rect.linewidth = 6;
    return this.two.update();
  };

  Cell.prototype.hide = function() {
    this.cell.visible = false;
    return this.two.update();
  };

  Cell.prototype.getX = function(col) {
    if (col == null) {
      col = this.col;
    }
    return this.board.x - (this.board.size + this.size) / 2 + (col + 1) * this.board.change;
  };

  Cell.prototype.getY = function(row) {
    if (row == null) {
      row = this.row;
    }
    return this.board.y - (this.board.size + this.size) / 2 + (row + 1) * this.board.change;
  };

  Cell.prototype.setIndices = function(row, col) {
    if ((row != null) && (col != null)) {
      this.row = row;
      return this.col = col;
    }
  };

  Cell.prototype.shiftTo = function(row, col) {
    var end, goingDown, start;
    end = new Two.Vector(this.getX(col), this.getY(row));
    start = new Two.Vector(this.getX(), this.getY());
    goingDown = end.y > start.y;
    this.two.bind('update', (function(_this) {
      return function(frameCount) {
        var delta, dist;
        dist = start.distanceTo(end);
        if (dist < .00001) {
          _this.cell.translation.clone(end);
          _this.two.unbind('update');
        }
        delta = new Two.Vector(0, dist * .125);
        if (goingDown) {
          _this.cell.translation.addSelf(delta);
          return start = start.addSelf(delta);
        } else {
          _this.cell.translation.subSelf(delta);
          return start = start.subSelf(delta);
        }
      };
    })(this)).play();
    return this.setIndices(row, col);
  };

  Cell.prototype.select = function() {
    this.isSelected = true;
    return this.setColor(Colors.select);
  };

  Cell.prototype.unSelect = function() {
    this.isSelected = false;
    return this.setColor(Colors.cell);
  };

  Cell.prototype.bindClick = function() {
    if (this.clickHandler == null) {
      return;
    }
    return $(this.cell._renderer.elem).click((function(_this) {
      return function(e) {
        e.preventDefault();
        if (_this.isDeleted) {
          return;
        }
        if (_this.isSelected) {
          _this.clickHandler.unclickCell(_this);
        } else {
          _this.clickHandler.clickCell(_this);
        }
        return e.stopPropagation();
      };
    })(this));
  };

  Cell.prototype.x = function() {
    return this.col;
  };

  Cell.prototype.y = function() {
    return this.row;
  };

  Cell.prototype["delete"] = function() {
    this.hide();
    return this.isDeleted = true;
  };

  return Cell;

})();

module.exports = Cell;
