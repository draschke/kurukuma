
request = $.ajax('http://kurukuma.herokuapp.com/page/twitter_info', {
  type:     "get",
  dataType: "json",
  success: (data) =>
    console.log('ajax:twitter_info')
    console.log(data)
    if data.redirect_url
      # extensionではリダイレクトさせない
      #location.href = data.redirect_url
      #return false
    else
      back = chrome.extension.getBackgroundPage()
      back.kurukuma_user_info = data.twitter_info.info
})
