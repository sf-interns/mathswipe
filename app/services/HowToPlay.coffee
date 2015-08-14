$ = require 'jquery'

class HowToPlay

  @createHowToPlay: (isMobile) ->
    elemById = $('#how-to-play')
    if isMobile().any()?
      elemById.append('<b>How To Play:</b> Solve the puzzle by
        clearing the board. Click adjacent tiles to create an
        equation, and if it equals an answer, the tiles disappear!')
    else
      elemById.append('<b>How To Play:</b> Solve the puzzle by
        clearing the board. Drag your mouse across the tiles to create an
        equation, and if it equals an answer, the tiles disappear!')
    elemById.append('<br><br>')
    elemById.append('<b>Tip:</b> Cells can be selected diagonally!')
    elemById.append('<br>')
    elemById.append('<b>Tip:</b> Select multiple number tiles to create a
        multi-digit number!')
    elemById.append('<br><br>')

module.exports = HowToPlay
