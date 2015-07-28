DFS          = require ("./app/services/DFS")
GameGrid     = require ("./app/models/GameGrid")
InputSolver  = require ("./app/services/InputSolver")
LastInColumn = require ("./app/services/LastInColumn")

# grid = [[null, null, 1],
#         [3, 4, 3],
#         [4, 4, null]]
# checker = new LastInColumn
# console.log checker.isLastAndBlocking(grid)
@grid = new GameGrid(3)
testGrid = new DFS @grid
seed = {x: 1, y: 1}
testGrid.search seed, "1+2"
console.log @grid.grid[0]
console.log @grid.grid[1]
console.log @grid.grid[2]
testGrid.search seed, "3-4"
console.log @grid.grid[0]
console.log @grid.grid[1]
console.log @grid.grid[2]
