$ = jQuery

$ ->
  #fichier upload
  if fichier_name = $("#communication_fichier_link").data("fichier-name")
    $(".communication_fichier").show()
    $("a#communication_fichier_link").text(fichier_name)
    $("a#communication_fichier_link").attr("href", $("#communication_fichier_link").data("fichier-url"))

  $('#s3-uploader').S3Uploader()

  $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    html = "<div class='form-group'"
    $('.communication_fichier').show()
    $("a#communication_fichier_link").text(content.filename)
    $("a#communication_fichier_link").attr("href", content.url)
    url = $("a#communication_fichier_delete").data("url")
    $("a#communication_fichier_delete").attr("href", "#{url}?filepath=#{content.url}")
    $('#communication_fichier_url').val(content.url)
    $('#communication_fichier_name').val(content.filename)
    $('label.s3-uploader-file').text("Joindre un nouveau fichier")

  $('#s3-uploader').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")

  #tags
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
