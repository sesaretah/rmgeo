module Api::V3
  class ApiController < ApplicationController
    include Response
    include JsonValidator
    include Geometry
    before_action :set_area, only: [:contains] # Checks if an area exists, responds 422 if it fails
    before_action :set_location, only: [:contains] # Checks if the location exists, responds 422 if it fails
    before_action :geo_json_valid?, only: [:areas, :contains] # Checks if the given params conforms with RFC 7946 standard, responds 422 if it fails
    before_action :is_point?, only: [:contains] # Checks if the given params is a point, responds 422 if it fails

    def locations
      @location = Location.new(name: params[:name])
      if @location.save
        json_response([id: @location.id], :created, :location_saved)
      else
        json_response(nil, :error, :db_error)
      end
    end

    def contains
      json_response([inside: custom_pip?(@area, params)])
    end

    private
    #Sets area, responds 422 if it doesn't exist
    def set_area
      @area = Area.find_by_id(params[:id])
      if @area.blank?
        json_response(nil, :unprocessable_entity, :invalid_area_id)
      end
    end

    #Sets area, responds 422 if it doesn't exist
    def set_location
      @location = Location.find_by_id(params[:id])
      if @location.blank?
        json_response(nil, :unprocessable_entity, :invalid_location_id)
      end
    end

  end
end
