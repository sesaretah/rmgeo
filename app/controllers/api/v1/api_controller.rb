module Api::V1
  class ApiController < ApplicationController
    include Response
    include JsonValidator
    include Geometry
    before_action :set_area, only: [:inside_checker]
    before_action :geo_json_valid?, only: [:areas, :inside_checker]

    def areas
      @area = Area.new(geo_json: params[:api].to_json)
      if @area.save
        json_response([id: @area.id], :ok, :geo_json_recieved)
      else
        json_response(nil, :error, :db_error)
      end
    end

    def inside_checker
      json_response([inside: check_overlap(@area, params)])
    end

    def set_area
      @area = Area.find_by_id(params[:id])
      if @area.blank?
        json_response(nil, :error, :invalid_id)
      end
    end

  end
end
