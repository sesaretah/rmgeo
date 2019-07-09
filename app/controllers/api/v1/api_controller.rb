module Api::V1
  class ApiController < ApplicationController
    before_action :set_area, only: [:contains] # Checks if an area exists, responds 422 if it fails
    before_action :geo_json_valid?, only: [:contains] # Checks if the given params conforms with RFC 7946 standard, responds 422 if it fails
    before_action :is_point?, only: [:contains] # Checks if the given params is a point, responds 422 if it fails

    # POST '/api/v1/contains/:id' where :id is the identifier of an area. Extracts a geojson point from ...
    #... params and checks if area contains the point, responds 422 if point doesn't conform with RFC 7946
    def contains
      json_response([inside: pip?(@area, params)])
    end

  end
end
