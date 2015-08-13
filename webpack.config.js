module.exports = {
  entry: ['./index'],
  output: {
    path: './',
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ["", ".coffee", ".js"],
    moduleDirectories: ["js", "node_modules"]
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee-loader"},
      { test: /\.(png|woff|woff2|eot|ttf|svg)$/, loader: 'url-loader?limit=100000' }
    ]
  }
};
