module JsonValidator
  extend ActiveSupport::Concern
  include Response
  #Checks if the given params conforms with RFC 7946, responds 422 if it fails
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
