InputSolver = require '../app/InputSolver'
expect = chai.expect

describe 'InputSolver', ->
  describe '#isOperator()', ->
    isOp = InputSolver.isOperator
    it 'should return true when value is operator', ->
      (expect isOp '+' ).to.equal true
      (expect isOp '-' ).to.equal true
      (expect isOp '*' ).to.equal true

    it 'should return false when value is not an operator', ->
      (expect isOp '1').to.equal false
      (expect isOp '?').to.equal false

    it 'should return false when input is empty', ->
      (expect isOp '').to.equal false

  describe '#operation()', ->
    OP = (operation) -> 
      return InputSolver.operation(12, '3', operation)

    it 'adds when given plus sign', ->
      (expect OP '+').to.equal 15

    it 'subtracts when given minus sign', ->
      (expect OP '-').to.equal 9

    it 'mulitplies when given star', ->
      (expect OP '*').to.equal 36

    it 'performs no operation when given invalid op', ->
      (expect OP '7').to.equal 12

  describe '#compute()', ->
    compute = (str) -> InputSolver.compute str 
    it 'linearly evaluates numbers', ->
      expect(compute '12').to.equal 12
      expect(compute '4' ).to.equal 4

    it 'linear evaluates simple expressions', ->
      expect(compute '1+3').to.equal 4
      expect(compute '4*3').to.equal 12
      expect(compute '3-7').to.equal -4  

    it 'doesn\'t evaluate incomplete expressions', ->
      expect(compute '1+'  ).to.equal 1
      expect(compute '1+7*').to.equal 8

    it 'doesn\'t follow the order of operations', ->
      expect(compute '3-1*4').to.equal 8
