class ApplicationController < ActionController::API

  include ApiAuthenticable
  before_action :authenticate_user

end