InputSolver = require ("./app/services/InputSolver")
GameGrid    = require ("./app/models/GameGrid")
DFS         = require ("./app/services/DFS")
LastInColumn         = require ("./app/services/LastInColumn")

# grid = [[null, null, 1],
#         [3, 4, 3],
#         [4, 4, null]]
# checker = new LastInColumn
# console.log checker.isLastAndBlocking(grid)
@grid = new GameGrid(3)
testGrid = new DFS @grid
seed = {x: 1, y: 1}
testGrid.search seed, "1+3"
console.log @grid.grid
