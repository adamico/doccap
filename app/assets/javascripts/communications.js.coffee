$ = jQuery

$ ->
  #fichier upload
  if fichier_name = $("#communication_fichier_link").data("fichier-name")
    $(".communication_fichier").show()
    $("a#communication_fichier_link").text(fichier_name)
    $("a#communication_fichier_link").attr("href",
      $("#communication_fichier_link").data("fichier-url"))

  $('#s3-uploader').S3Uploader()

  $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    html = "<div class='form-group'"
    $('.communication_fichier').show()
    $("a#communication_fichier_link").text(content.filename)
    $("a#communication_fichier_link").attr("href", content.url)
    url = $("a#communication_fichier_delete").data("url")
    $("a#communication_fichier_delete").attr("href",
      "#{url}?filepath=#{content.url}")
    $('#communication_fichier_url').val(content.url)
    $('#communication_fichier_name').val(content.filename)
    $('label.s3-uploader-file').text("Joindre un nouveau fichier")

  $('#s3-uploader').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")

  #tags
  $("#communication_tag_list").select2
    minimumInputLength: 3
    tags: true
    tokenSeparators: [","]
    createSearchChoice: (term, data) ->
      if $(data).filter(
        -> return this.text.localeCompare(term) is 0
      ).length is 0
        { id: term, text: term }
    multiple: true
    initSelection : (element, callback) ->
      preload = element.data("load")
      callback(preload)
    ajax:
      url: $("#communication_tag_list").data("url")
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}

  # category
  $("#communication_category_id").attachCategorySelect2()
  $("#communication_category_id_field").remoteCategoryForm()

  category_id = $("#communication_category_id").val()
  activateCategoryEdit(category_id)

$.fn.attachCategorySelect2 = ->
  @select2
    width: "100%"
    initSelection : (element, callback) ->
      preload = element.data("load")
      callback(preload)
    ajax:
      url: $("#communication_category_id").data("source")
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}
  @on "change", (e) =>
    if e.added
      category_id = e.added.id
      console.log "Category changed : #{category_id}"
      activateCategoryEdit(category_id)
    else
      $(".category_update").hide()

activateCategoryEdit = (category_id) ->
  $edit_btn = $(".category_update")
  $edit_btn.attr("href", "/admin/categories/#{category_id}/edit")
  if category_id then $edit_btn.show() else $edit_btn.hide()

$.widget "doccap.remoteCategoryForm",

  _create: ->
    dom_widget = @element
    $(".category_create").unbind().bind "click", (e) =>
      @_bindModalOpening e, $(e.target).attr("href")

    $(".category_update").unbind().bind "click", (e) =>
      if (category_id = $("#communication_category_id").val())
        console.dir category_id
        @_bindModalOpening e,
          $(e.target).attr("href").replace('__ID__', category_id)
      else
        e.preventDefault()

  _bindModalOpening: (e, url) ->
    console.log("bindmodalopening started")
    e.preventDefault()
    dialog = @_getModal()

    setTimeout(=>
      console.log("timeout")
      $.ajax
        url: url
        beforeSend: (xhr) ->
          xhr.setRequestHeader "Accept", "text/javascript"
        success: (data, status, xhr) =>
          dialog.find(".modal-body").html(data)
          @_bindFormEvents()
        error: (xhr, status, error) ->
          dialog.find(".modal-body").html(xhr.responseText)
        dataType: "text"
      , 200)

  _bindFormEvents: ->
    console.log("started bindFormEvents")
    dialog = @_getModal()
    form = dialog.find("form")
    saveButtonText = "Enregistrer"
    dialog.find('.form-actions').remove()

    form.attr("data-remote", true)
    dialog.find('#modal-label').text form.data('title')
    dialog.find(".save-action").unbind().click(->
      form.submit()
      return false
    ).html(saveButtonText)

    form.bind "ajax:complete", (e, xhr, status) =>
      if status is "error"
        dialog.find(".modal-body").html xhr.responseText
        @_bindFormEvents()
      else
        json = $.parseJSON xhr.responseText
        category_label = json.label
        category_id = json.id
        $edit_btn = $("#communication_category_id_field .category_update")
        $edit_btn.attr("href", "/admin/categories/#{category_id}/edit")
        $edit_btn.show()
        $select = @element.find("#communication_category_id")
        $select.select2("data", {id: category_id, text: category_label})
        @_trigger("success")
        dialog.modal("hide")

  _getModal: ->
    console.log("launched _getModal")
    unless @dialog
      @dialog = $('<div id="category_modal" class="modal fade" role="dialog" aria-labelledby="modal-label" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modal-label">...<h3>
              </div>
              <div class="modal-body">
                ...
              </div>
              <div class="modal-footer">
                <a href="#" class="btn btn-primary save-action">...</a>
                <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Fermer</button>
              </div>
            </div>
          </div>
        </div>')
        .modal(
          keyboard: true
          backdrop: true
          show: true
        ).on "hidden.bs.modal", =>
          @dialog.remove()
          @dialog = null
    console.log("dialog loaded with _getModal func")
    return @dialog
