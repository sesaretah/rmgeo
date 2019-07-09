class ApplicationController < ActionController::API
  include Response
  include JsonValidator
  include Geometry
  before_action :geo_json_valid?, only: [:areas] # Checks if the given params conforms with RFC 7946 standard, responds 422 if it fails
  before_action :is_collection?, only: [:areas] # Checks if the params is a feature collecrion

  # POST '/api/vx/areas' extracts a geojson and saves it in database, responds 500 if it fails
  # Since every version has this same functionality
  def areas
    @area = Area.new(geo_json: params.to_json)
    if @area.save
      json_response([id: @area.id], :created, :geo_json_recieved)
    else
      json_response(nil, :error, :db_error)
    end
  end

  protected
  #Sets area, responds 422 if it doesn't exist
  def set_area
    @area = Area.find_by_id(params[:id])
    if @area.blank?
      json_response(nil, :unprocessable_entity, :invalid_id)
    end
  end

  #This issue still exists in rails, this is just a workaround to handle parse error
  def process_action(*args)
    super
  rescue ActionDispatch::Http::Parameters::ParseError => exception
    json_response(nil ,400, :bad_request)
  end

  #This handles routing errors for api
  def routing_error(error = 'Routing error', status = :not_found, exception=nil)
    json_response(nil ,:not_found, :routing_error)
  end
end
