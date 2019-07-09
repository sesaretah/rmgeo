module Api::V3
  class ApiController < ApplicationController
    before_action :set_area, only: [:contains] # Checks if an area exists, responds 422 if it fails
    before_action :set_location, only: [:contains] # Checks if the location exists, responds 422 if it fails

    # POST /api/v3/locations, Accepts location name and saves it id database, there is a ..
    #.. after_create callback which extracts the longitude/latitude of the location if it exists
    def locations
      @location = Location.new(name: params[:name])
      if @location.save
        json_response([id: @location.id], :created, :location_saved)
      else
        json_response(nil, :error, :db_error)
      end
    end

    # GET /api/v3/contains/area_id/location_id checks if area contains the location
    def contains
      json_response([inside: custom_pip?(@area, geo_jsonify(@location))])
    end

    private

    #Sets area, responds 422 if it doesn't exist
    def set_location
      @location = Location.find_by_id(params[:id])
      if @location.blank?
        json_response(nil, :unprocessable_entity, :invalid_location_id)
      end
    end

  end
end
