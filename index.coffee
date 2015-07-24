InputSolver = require ("./app/services/InputSolver")
GameGrid    = require ("./app/models/GameGrid")
DFS         = require ("./app/services/DFS")

cat = new DFS
seed = {x: 1, y: 1}
cat.DFS seed
