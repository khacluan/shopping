class ApplicationController < ActionController::Base
  include Shopping::CartHelpers

  protect_from_forgery with: :exception

  def require_xhr
    fail 'Bad request (require xhr request)' unless request.xhr?
  end
end

