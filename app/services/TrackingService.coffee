class TrackingService

  @boardEvent: (label) ->
    return unless (typeof ga)?
    if label?
      ga 'send', 'event', 'board', label
    else
      ga 'send', 'event', 'board'

  @mobileView: ->
    @pageview 'Mobile'

  @desktopView: ->
    @pageview 'Desktop'

  @pageview: (label) ->
    return unless (typeof ga)?
    if label?
      ga 'send', 'pageview', label
    else
      ga 'send', 'pageview'

module.exports = TrackingService
