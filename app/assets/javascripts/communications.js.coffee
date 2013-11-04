$ = jQuery

$ ->
  for name in ["communication_tag"]
    $("##{name}s").select2
      minimumInputLength: 3
      tags: true
      tokenSeparators: [","]
      createSearchChoice: (term, data) ->
        return { id: term, text: term } if $(data).filter(-> return this.text.localeCompare(term) is 0).length is 0
      multiple: true
      initSelection : (element, callback) ->
        preload = element.data("load")
        callback(preload)
      ajax:
        url: $("##{name}s").data("url")
        dataType: "json"
        data: (term, page) ->
          q: term
          page_limit: 10
        results: (data, page) ->
          return {results: data}
