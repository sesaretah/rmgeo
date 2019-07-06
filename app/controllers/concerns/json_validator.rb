module JsonValidator
  extend ActiveSupport::Concern
  include Response
  def geo_json_valid?
    geo_data = RGeo::GeoJSON.decode(params.to_json)
    if !geo_data.blank?
      return true
    else
      json_response(nil, :unprocessable_entity, :invalid_geojson_type)
      return false
    end
  end
end
