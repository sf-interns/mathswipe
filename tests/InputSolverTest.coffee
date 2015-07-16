InputSolver = require '../app/InputSolver'
assert = require 'assert'

describe 'InputSolver', ->
  describe '#isOperator()', ->
    it 'should return true when value is operator', ->
      assert.equal true, InputSolver.isOperator('+')
      assert.equal true, InputSolver.isOperator('-')
      assert.equal true, InputSolver.isOperator('*')

    it 'should return false when value is not an operator', ->
      assert.equal false, InputSolver.isOperator('1')
      assert.equal false, InputSolver.isOperator('2')

    it 'should return false when input is empty', ->
      assert.equal false, InputSolver.isOperator('')
