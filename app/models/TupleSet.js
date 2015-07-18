// Generated by CoffeeScript 1.9.3
var TupleSet,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TupleSet = (function() {
  function TupleSet(tuples) {
    var i, len, t;
    if (tuples == null) {
      tuples = [];
    }
    this.at = bind(this.at, this);
    this.length = bind(this.length, this);
    this.pop = bind(this.pop, this);
    this.push = bind(this.push, this);
    this.set = [];
    for (i = 0, len = tuples.length; i < len; i++) {
      t = tuples[i];
      this.push(t);
    }
  }

  TupleSet.prototype.push = function(tuple) {
    if (!(tuple === null || tuple.isElementOf(this.set))) {
      return this.set.push(tuple);
    }
  };

  TupleSet.prototype.pop = function() {
    return this.set.pop();
  };

  TupleSet.prototype.length = function() {
    return this.set.length;
  };

  TupleSet.prototype.at = function(idx) {
    if (idx < this.length()) {
      return this.set[idx];
    }
    return false;
  };

  return TupleSet;

})();

module.exports = TupleSet;
