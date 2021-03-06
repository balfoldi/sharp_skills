# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!, only: [:autenticate_admin!]

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end

  def autenticate_admin!
    if current_user.type != "admin"
      render json: {error: "Current user must be an admin."}, status:403
      return false
    end
    return true
  end
  
end