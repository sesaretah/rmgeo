module Api::V1
  class ApiController < ApplicationController
    include Response
    include JsonValidator
    include Geometry
    before_action :set_area, only: [:contains] # Checks if an area exists, responds 422 if it fails
    before_action :geo_json_valid?, only: [:areas, :contains] # Checks if the given params conforms with RFC 7946 standard, responds 422 if it fails
    before_action :is_point?, only: [:contains] # Checks if the given params is a point, responds 422 if it fails
    before_action :is_collection?, only: [:areas] # Checks if the params is a feature collecrion

    # POST '/api/v1/areas' extracts a geojson and saves it in database, responds 500 if it fails
    def areas
      @area = Area.new(geo_json: params.to_json)
      if @area.save
        json_response([id: @area.id], :created, :geo_json_recieved)
      else
        json_response(nil, :error, :db_error)
      end
    end

    # POST '/api/v1/contains/:id' where :id is the identifier of an area. Extracts a geojson point from ...
    #... params and checks if area contains the point, responds 422 if point doesn't conform with RFC 7946
    def contains
      json_response([inside: overlap?(@area, params)])
    end

    private
    #Sets area, responds 422 if it doesn't exist
    def set_area
      @area = Area.find_by_id(params[:id])
      if @area.blank?
        json_response(nil, :unprocessable_entity, :invalid_id)
      end
    end

  end
end
