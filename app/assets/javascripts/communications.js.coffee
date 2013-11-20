$ = jQuery

$ ->
  #fichier upload
  $('#s3-uploader').S3Uploader()

  $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    console.dir content
    html = "<div class='form-group'"
    $('.form-group.communication_fichier_name').show()
    $("a#communication_fichier_link").text(content.filename)
    $("a#communication_fichier_link").attr("href", content.url)
    $('#communication_fichier_url').val(content.url)
    $('#communication_fichier_name').val(content.filename)

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
