// Generated by CoffeeScript 1.9.3
var $, Title;

$ = require('jquery');

Title = (function() {
  function Title() {}

  Title.mobileTitle = function() {
    var elemById;
    elemById = $('#title');
    return elemById.css('font-size', '16vw');
  };

  return Title;

})();

module.exports = Title;
