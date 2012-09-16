
request = $.ajax('http://kurukuma.herokuapp.com/page/twitter_info', {
  type:     "get",
  dataType: "json",
  success: (data) =>
    console.log('ajax:twitter_info')
    console.log(data)
    if data.redirect_url
      chrome.tabs.create({url: data.redirect_url})
      return false
    else
      back = chrome.extension.getBackgroundPage()
      back.kurukuma_user_info = data.twitter_info
      
      size = 36
      ui = data.twitter_info
      string = '<div class="annotator-twitter">'
      string += '<div class="annotator-twitter-image">'
      string += '<img src="' + ui.image + '" width=' + size + ' height=' + size + ' />'
      string += '</div>'
      string += '<div class="annotator-twitter-profile">@' + ui.nickname
      string += '</div>'
      string += '<div class="annotator-twitter-profile">' + ui.location + '</div>'
      string += '</div>'
      $("body").html(string)
})
