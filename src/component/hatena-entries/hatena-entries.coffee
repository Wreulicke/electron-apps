Polymer
  is: 'hatena-entries'
  properties: {}
  listeners:
    response: 'test'
  response: (e, req) ->
    this.fire('response', req)
  test: (e, req) ->
    console.log 'res', @, arguments, req.response
    xml = req.response
    nodes = xml.children[0].children
    datas = for node in Array::slice.apply nodes, [1]
      result = {}
      for child in node.children
        result[child.tagName] = child.innerHTML
      result
    @datas = datas
    return
