$ = require 'jquery'

class HowToPlay

  @createHowToPlay: (isMobile) ->
    if isMobile().any()?
      $('#how-to-play').append('<b>How To Play:</b> Solve the puzzle by
        clearing the board. Click adjacent tiles to create an
        equation, and if it equals an answer, the tiles disappear!')
    else
      $('#how-to-play').append('<b>How To Play:</b> Solve the puzzle by
        clearing the board. Drag your mouse across the tiles to create an
        equation, and if it equals an answer, the tiles disappear!')

module.exports = HowToPlay
