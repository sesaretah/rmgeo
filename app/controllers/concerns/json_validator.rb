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

  #Checks if the given params is a geojson point, responds 422 if it is not
  def is_point?
    point_data = RGeo::GeoJSON.decode(params.to_json)
    if point_data.blank? || point_data.geometry.geometry_type.to_s != 'Point'
      json_response(nil, :unprocessable_entity, :incompatible_geomtry)
    end
  end

  #Checks if the given params is a geojson feature collection, responds 422 if it is not
  def is_collection?
    collection_data = RGeo::GeoJSON.decode(params.to_json)
    if collection_data.blank? || !defined?(collection_data.size) || collection_data.size.blank?
      json_response(nil, :unprocessable_entity, :incompatible_geomtry)
    end
  end
end
