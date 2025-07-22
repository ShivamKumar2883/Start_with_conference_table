class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
    protect_from_forgery with: :exception
    allow_browser versions: :modern

end
