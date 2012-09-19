
chrome.extension.onRequest.addListener((request, sender, sendResponse)->
  console.log(33)
  chrome.tabs.sendRequest(sender.tab.id, {user_info: window.kurukuma_user_info})
)
chrome.tabs.getSelected(null, (tab)->
  console.log(tab.title)
  chrome.tabs.sendRequest(tab.id, {greeting: "hello"}, (response)->
    console.log(response)
    
  )
)

request = $.ajax('http://'+kurukuma.domain+'/messages/twitter_info', {
  type:     "get",
  dataType: "json",
  success: (data) =>
    console.log('background:twitter_info')
    console.log(data)
    if data.redirect_url
      return false
    else
      console.log(window)
      window.kurukuma_user_info = data.twitter_info
      
      size = 36
      ui = data.twitter_info
      string = '<div class="annotator-twitter">'
      string += '<div class="annotator-twitter-image">'
      string += '<img src="' + ui.image + '" width=' + size + ' height=' + size + ' />'
      string += '</div>'
      string += '<div class="annotator-twitter-profile">@' + ui.nickname
      string += '</div>'
      string += '<div class="annotator-twitter-location">' + ui.location + '</div>'
      string += '</div>'
      $("body").html(string)
})
