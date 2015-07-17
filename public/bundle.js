/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/*!******************!*\
  !*** multi main ***!
  \******************/
/***/ function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__(/*! ./index */1);


/***/ },
/* 1 */
/*!**********************!*\
  !*** ./index.coffee ***!
  \**********************/
/***/ function(module, exports, __webpack_require__) {

	var InputSolver;
	
	InputSolver = __webpack_require__(/*! ./app/InputSolver */ 2);
	
	console.log(InputSolver.compute("1+2*-3"));


/***/ },
/* 2 */
/*!********************************!*\
  !*** ./app/InputSolver.coffee ***!
  \********************************/
/***/ function(module, exports) {

	var InputSolver;
	
	InputSolver = (function() {
	  function InputSolver() {}
	
	  InputSolver.parseInput = function(input) {
	    var numberRegex, numbers;
	    numberRegex = /([0-9]+|[\+\-\*])/g;
	    return numbers = input.match(numberRegex);
	  };
	
	  InputSolver.isOperator = function(element) {
	    return element === "+" || element === "-" || element === "*";
	  };
	
	  InputSolver.operation = function(sum, element, op) {
	    if (op === "+") {
	      sum = sum + parseInt(element);
	    } else if (op === "-") {
	      sum = sum - parseInt(element);
	    } else if (op === "*") {
	      sum = sum * parseInt(element);
	    }
	    return sum;
	  };
	
	  InputSolver.compute = function(input) {
	    var element, i, len, previous, sum;
	    input = this.parseInput(input);
	    previous = input[0];
	    sum = parseInt(input[0]);
	    if (isNaN(sum)) {
	      return NaN;
	    }
	    for (i = 0, len = input.length; i < len; i++) {
	      element = input[i];
	      if ((this.isOperator(previous)) && (this.isOperator(element))) {
	        return sum;
	      }
	      sum = this.operation(sum, element, previous);
	      previous = element;
	    }
	    return sum;
	  };
	
	  return InputSolver;
	
	})();
	
	module.exports = InputSolver;


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map