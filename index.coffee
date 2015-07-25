InputSolver = require ("./app/services/InputSolver")
GameGrid    = require ("./app/models/GameGrid")
DFS         = require ("./app/services/DFS")
LastInColumn         = require ("./app/services/LastInColumn")

grid = [[null, null, 1],
        [3, 4, 3],
        [4, 4, null]]
checker = new LastInColumn
console.log checker.isLastAndBlocking(grid)

cat = new DFS
seed = {x: 1, y: 1}
cat.DFS seed
