module Response
  extend ActiveSupport::Concern
  def json_response(result, status = :ok, message = :successful)
     render json: {result: result, message: I18n.t(message)}, status: status
   end
end
