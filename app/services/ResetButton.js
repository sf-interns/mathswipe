// Generated by CoffeeScript 1.9.3
var $, ResetButton;

$ = require('jquery');

ResetButton = (function() {
  function ResetButton(board) {
    this.board = board;
  }

  ResetButton.prototype.bindClick = function() {
    return $('#reset-button').click((function(_this) {
      return function(e) {
        return _this.board.resetBoard();
      };
    })(this));
  };

  return ResetButton;

})();

module.exports = ResetButton;