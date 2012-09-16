// Generated by CoffeeScript 1.3.3
(function() {
  var request,
    _this = this;

  chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
    console.log(33);
    return chrome.tabs.sendRequest(sender.tab.id, {
      user_info: window.kurukuma_user_info
    });
  });

  chrome.tabs.getSelected(null, function(tab) {
    console.log(tab.title);
    return chrome.tabs.sendRequest(tab.id, {
      greeting: "hello"
    }, function(response) {
      return console.log(response);
    });
  });

  request = $.ajax('http://kurukuma.herokuapp.com/page/twitter_info', {
    type: "get",
    dataType: "json",
    success: function(data) {
      var size, string, ui;
      console.log('background:twitter_info');
      console.log(data);
      if (data.redirect_url) {
        return false;
      } else {
        console.log(window);
        window.kurukuma_user_info = data.twitter_info;
        size = 36;
        ui = data.twitter_info;
        string = '<div class="annotator-twitter">';
        string += '<div class="annotator-twitter-image">';
        string += '<img src="' + ui.image + '" width=' + size + ' height=' + size + ' />';
        string += '</div>';
        string += '<div class="annotator-twitter-profile">@' + ui.nickname;
        string += '</div>';
        string += '<div class="annotator-twitter-location">' + ui.location + '</div>';
        string += '</div>';
        return $("body").html(string);
      }
    }
  });

}).call(this);
