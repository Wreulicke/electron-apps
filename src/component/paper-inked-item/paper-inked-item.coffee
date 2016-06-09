Polymer
  is: 'paper-inked-item'
  properties: {}
  listeners:
    tap: 'onTapped'
  onTapped: ->
    return true
  behaviors: [
    Polymer.PaperItemBehavior
  ]
  ready: ->
    console.log "test"
