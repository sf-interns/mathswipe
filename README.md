# MathSwipe

MathSwipe is a `CoffeeScript` game developed in the context of the [Originate](http://www.originate.com/) 'Intern Hack 2015' Event, presented August 2015.  It is a web-game in which the user is given a grid of numbers (0-9) and operators (&times;, +, -), as well as a set of goal-values.  The user's goal is to swipe a path through the cells to create an expression that evaluates to one of the goal-values. A level is completed when the user finds expressions evaluating to each goal-value.

## Development Information

Note that the other services, when run locally, expect the frontend to be served on port 8080.

The codebase is primarily written in CoffeeScript, including wrappers for creating React elements. The entire project (including its dependencies) is bundled before runtime by webpack, which serves up a single bundle.js file.

### Stack

- [Coffeescript](http://coffeescript.org/)
- [Webpack](http://webpack.github.io/docs/) for bundling
- [Mycha](https://github.com/Originate/mycha) for `CoffeeScript` tests

### Installation

1. Install local npm modules

 ```npm install```

2. Ensure `CoffeeScript` is installed locally, if not, run
 ```npm install -g coffee-script```

3. And start the dev server

 ```npm run devserve```

  * If that script fails because node can't find webpack-dev-serve*:

  Make sure `webpack-dev-server` is installed globally

   ```npm install webpack-dev-server -g```

### Testing
This project uses [Mycha](https://github.com/Originate/mycha) for its tests. All test files should be put in the directory `./tests`.  To run the entire test suite, run `mycha`.  To run a specific test, provide a file name.

## Github Pages Information

### Hosting
The website is hosted, currently, at <http://sf-interns.github.io/mathswipe/>.  The `CNAME` file specifies the url from which the page can be accessed. After about 7/14/15 at noon, the website will be available at <http://mathswipe.com/>.

### Development
 - The `master` branch is our 'development' branch.  Changes should be merged here and it reflects the most recent version of our best code.
 - The `gh-pages` branch is the 'production' branch.  This branch reflects the state of our site 
