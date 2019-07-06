class ApplicationController < ActionController::API
  include Response

  #This issue still exists in rails, this is just a workaround
  def process_action(*args)
    super
  rescue ActionDispatch::Http::Parameters::ParseError => exception
    json_response(nil ,400, :bad_request)
  end

  def routing_error(error = 'Routing error', status = :not_found, exception=nil)
    json_response(nil ,:not_found, :routing_error)
  end
end
