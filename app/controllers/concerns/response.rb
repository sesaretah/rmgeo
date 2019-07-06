module Response
  extend ActiveSupport::Concern
  # Renders JSON to the requester
  def json_response(result, status = :ok, message = :successful)
     render json: {result: result, message: I18n.t(message)}, status: status
   end
end
