chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

global.chai = chai
global.expect = chai.expect
global.sinon = sinon

global.app_path = '../..'

process.env.NODE_ENV = 'test'