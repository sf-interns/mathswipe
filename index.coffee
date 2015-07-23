Two        = require 'two.js'
MathSwipeController = require './app/controllers/MathSwipeController'

game = new MathSwipeController
game.deleteCell(2,1)
# game.pushAllCellsToBottom()
game.deleteCell(1,1)
# game.pushAllCellsToBottom()
game.deleteCell(2,2)
game.pushAllCellsToBottom()
