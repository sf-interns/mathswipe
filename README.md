# Math Brain

[Math Brain](http://sf-interns.github.io/mathbrain/) is a `CoffeeScript` game developed in the context of the [Originate](http://www.originate.com/) 'Intern Hack 2015' Event, presented August 2015.  It is a web-game in which the user is given a grid of numbers (0-9) and operators (+, -, &times;). The user's goal is to swipe a path through the cells to create an expression that evaluates to one of the goal-values listed below the board. A level is completed when the user finds expressions evaluating to each goal-value and has cleared the board of all cells.

## Development Information

Note that the other services, when run locally, expect the frontend to be served on port 8080.

The codebase is primarily written in CoffeeScript using the Node package manager to install most of the dependencies. The entire project (including its dependencies) is bundled by `Webpack` into a single bundle.js file which can be served locally or staticlly with GitHub pages.

Animation and functionality of the game is implemented using `jQuery`, `Two.js` and Scalable Vector Graphics (SVGs).

The styling is written in `SASS` and compiled down to CSS before use. If you plan to clone this repository and try building the game locally, we recommend using the Sublime plugin `SASS Build` to compile down to CSS.

### Stack

- [CoffeeScript](http://coffeescript.org/)
- [TwoJS](https://jonobr1.github.io/two.js/)
- [Webpack](http://webpack.github.io/docs/)
- [Mycha](https://github.com/Originate/mycha) for `CoffeeScript` tests

### Installation

1. Install local npm modules

```npm install```

2. Ensure `CoffeeScript` is installed locally, if not, run

```npm install -g coffee-script```

3. And start the dev server

```npm run devserve```

If that script fails because node can't find `webpack-dev-serve`, make sure `webpack-dev-server` is installed globally with: `npm install webpack-dev-server -g`

### Testing
This project uses [Mycha](https://github.com/Originate/mycha) for its tests. All test files should be put in the directory `./tests`. To run the entire test suite, run `mycha`. To run a specific test, provide a file name. For this project, in file `mycha.coffee`, the `testFilePattern` field should be `'**/*{Test,Tests}.{coffee,js}'`. Otherwise, your tests will not run.

## Github Pages Information

### Hosting
The website is hosted, currently, at <http://sf-interns.github.io/mathbrain/>.

### Development
 - The `master` branch is our 'development' branch. Branches for development of features and fixes are merged into this branch.
 - The `gh-pages` branch is our 'production' branch. This branch reflects a working state of the game at all times.
