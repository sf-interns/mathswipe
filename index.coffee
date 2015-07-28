DFS          = require ("./app/services/DFS")
GameGrid     = require ("./app/models/GameGrid")
InputSolver  = require ("./app/services/InputSolver")
LastInColumn = require ("./app/services/LastInColumn")
Tuple        = require "./app/models/Tuple"
TupleSet     = require "./app/models/TupleSet"

# grid = [[null, null, 1],
#         [3, 4, 3],
#         [4, 4, null]]
# checker = new LastInColumn
# console.log checker.isLastAndBlocking(grid)
@grid = new GameGrid(3)
testGrid = new DFS @grid
stringPlacement = new TupleSet
seed = {x: 1, y: 1}
# console.log "stringPlacement = ", stringPlacement
testGrid.search seed, "1+2", stringPlacement
console.log @grid.grid[0]
console.log @grid.grid[1]
console.log @grid.grid[2]
for each in stringPlacement
  console.log each

seed = stringPlacement.list[stringPlacement.length() - 1]
console.log seed
stringPlacement = new TupleSet
testGrid.search seed, "3-4", stringPlacement
console.log @grid.grid[0]
console.log @grid.grid[1]
console.log @grid.grid[2]

allCells = new TupleSet
for i in [0..@grid.dimension]
  for j in [0..@grid.dimension]
    allCells.push new Tuple i, j

for index in [0...allCells.length()]
  seed = allCells.at index
  stringPlacement = new TupleSet
  if testGrid.search seed, "5*6", stringPlacement
    break

console.log @grid.grid[0]
console.log @grid.grid[1]
console.log @grid.grid[2]
