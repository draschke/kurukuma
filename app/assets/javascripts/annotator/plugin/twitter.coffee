class Annotator.Plugin.Twitter extends Annotator.Plugin
  field: null
  input: null
  user_info: null
  options:
    image_size: 36
  
  pluginInit: ->
    return unless Annotator.supported()
    # twitter info get
    request = $.ajax(@options.prefix + 'page/twitter_info', {
      type:     "get",
      dataType: "json",
      success: (data) =>
        if data.redirect_url
          # extensionではリダイレクトさせない
          #location.href = data.redirect_url
          #return false
        else
          window.kurukuma_user_info = data.twitter_info
    })
    @annotator.viewer.addField({
      load: this.updateViewer
    })
    
    @field = @annotator.editor.addField({
      type: 'twitter'
      load: this.updateField
    })
    
    $(@annotator.editor.fields[0].element).bind({
      "keyup": (e)=>
        count = e.target.value.length
        $(@field).find(".annotator-twitter-counter").text(count)
    })
    
  updateViewer: (field, annotation) =>
    field = $(field)

    if annotation.twitter
      field.addClass('annotator-twitter').html(@getHtml(annotation.twitter))
    else
      field.remove()
  
  updateField: (field, annotation) =>
    field = $(field)
    if @user_info()
      field.addClass('annotator-twitter').html(@getHtml(@user_info(), true))
      count = $('#annotator-field-0')[0].value.length
      field.find(".annotator-twitter-counter").text(count)
    else
      field.remove()
  
  getHtml: (ui, editor_flg = false)=>
    size = @options.image_size
    string = '<div class="annotator-twitter-image">'
    string += '<img src="' + ui.image + '" width=' + size + ' height=' + size + ' />'
    string += '</div>'
    string += '<div class="annotator-twitter-profile">@' + ui.nickname
    unless editor_flg
      string += '&nbsp;(<a href="' + ui.twitter + '" target="_blank">view in twitter</a>)'
    string += '</div>'
    string += '<div class="annotator-twitter-profile">' + ui.location + '</div>'
    if editor_flg
      string += '<div class="annotator-twitter-counter">0</div>'
    return string
  initTextFormat: (text) ->
    text = '"' + text + '" - '
    text = text.replace(/\n/g, "");
    return text
  
  user_info:->
    return window.kurukuma_user_info

