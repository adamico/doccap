$ = jQuery

$ ->
  $(".alert-message").alert()
  $("[rel=tooltip]").tooltip
    delay:
      hide: 100

  $(".dropdown-toggle").dropdown()

  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} caractères"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."
  $.fn.select2.defaults.width = "100%"

  $("#search_spinner").hide()

  $("#search").on('ajax:send', (xhr) ->
    $("#search_spinner").show()
  ).on('ajax:complete', (xhr, status) ->
    $("#search_spinner").hide()
  )
