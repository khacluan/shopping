class ApplicationController < ActionController::Base
  include Shopping::CartHelpers
  helper_method :resource_name, :resource, :devise_mapping

  protect_from_forgery with: :null_session,
    if: -> { request.format.json? }

  def require_xhr
    fail 'Bad request (require xhr request)' unless request.xhr?
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end

