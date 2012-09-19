require 'oauth'
require 'json'
require 'bitly'

module TwitterApp
  def self.included(base)
    base.append_before_filter :auth_token, :only => [:twitter_info]
  end
  
  def twitter_info
    respond_to do |format|
      json = {:twitter_info => current_user.info}.to_json()
      format.html {render :json => json}
      format.json {render :json => json}
    end
  end

  protected
  def create_text(row)
    url = row.uri
    begin
      shortUrl = Page.where(url: url).first
      if shortUrl
        url = shortUrl.s_url
      else
        user_id = ENV['BITLY_USER_ID'] || Settings.bitly.user_id
        api_key = ENV['BITLY_API_KEY'] || Settings.bitly.api_key
        Bitly.use_api_version_3
        bitly = Bitly.new(user_id, api_key)
        ret = bitly.shorten(row.uri)
        url = ret.short_url
      end
    rescue => e
      logger.error sprintf('url shorten exception:%s', e.message)
    end
    
    count = 140 - 1 - url.length
    text = sprintf('%s %s', row.quote.to_s.slice(0, count), url)
    return text
  end

  def status_update(text)
    flg = ENV['TW_SEND_FLG'] || false
    return true unless flg
    
    key = ENV['TW_CONSUMER_KEY'] || Settings.twitter.consumer_key
    secret = ENV['TW_CONSUMER_SECRET'] || Settings.twitter.consumer_secret
    Twitter.configure do |config|
      config.consumer_key       = key
      config.consumer_secret    = secret
      config.oauth_token        = current_user.token
      config.oauth_token_secret = current_user.secret
    end

    twitter_client = Twitter::Client.new
    twitter_client.update(text)
  end

  private

  def auth_token
    if !session['user_id'] || !current_user
      # user_id不在ならOpenID
      url = url_for(:controller => :auth, :action => :twitter)
      respond_to do |format|
        json = {:redirect_url => url}.to_json()
        format.html {render :json => json}
        format.json {render :json => json}
      end
      return true
    end
    return true
  end
end
