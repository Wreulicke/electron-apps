Polymer
  is: 'main-panel'
  properties:
    title:
      type: String
      value: "init"
  listeners:
    'tap': 'test'
  test: (e) ->
    if e.target.link?
      @toggleAttribute('selected', false, e.target.parentNode)
      webview = @querySelector('#webview').setAttribute('src', e.target.link)
      @toggleAttribute('selected', true, webview)

  ready: ->
    console.log "test"
    console.log @
