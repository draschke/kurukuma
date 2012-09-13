class ApplicationController < ActionController::Base
  #protect_from_forgery
  before_filter :session_with_indifferent_access

  def login_required
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to root_path
    end

  end

  helper_method :current_user

  protected

  def root_path
    return '/'
  end


  def current_user
    return @current_user if @current_user
    begin
      @current_user = User.find(session[:user_id])
    rescue => e
      logger.error sprintf('current_user get exception:%s', e.message)
      @current_user = nil
    end
  end

  private

  def session_with_indifferent_access
    @session_for_refer = session.with_indifferent_access
  end
end
