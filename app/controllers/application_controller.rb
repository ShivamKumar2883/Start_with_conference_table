class ApplicationController < ActionController::Base

  include ApiAuthenticable
  before_action :authenticate_user

end