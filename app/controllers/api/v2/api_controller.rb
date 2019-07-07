module Api::V2
  class ApiController < ApplicationController
    before_action :set_area, only: [:contains] # Checks if an area exists, responds 422 if it fails
    before_action :geo_json_valid?, only: [:contains] # Checks if the given params conforms with RFC 7946 standard, responds 422 if it fails
    before_action :is_point?, only: [:contains] # Checks if the given params is a point, responds 422 if it fails


    # POST '/api/v2/contains/:id' where :id is the identifier of an area. Extracts a geojson point from ...
    #... params and checks if area contains the point, responds 422 if point doesn't conform with RFC 7946
    # *** Uses custom_pip which doesn't use any geo_utils for point_in_polygon(pip) problem
    def contains
      json_response([inside: custom_pip?(@area, params)])
    end

  end
end
