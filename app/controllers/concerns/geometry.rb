module Geometry
  extend ActiveSupport::Concern
  include Response
  # First it checks if the given point and region conforms with RFC 7946, responds 422 if it fails ...
  #.. then it checks wheter any of regions contain the point or not.
  #The method accepts Area class as the first paramter and a geo_json ruby hash as second
  def pip?(area, point_param)
    regions = RGeo::GeoJSON.decode(area.geo_json)
    point = RGeo::GeoJSON.decode(point_param.to_json)
    @flag = false
    for region in regions
      if region.geometry.contains?(point.geometry)
        @flag =  true
      end
    end
    return @flag
  end

  #This method accepts Area class as the first paramter and a geo_json ruby hash as second
  def custom_pip?(area, point_param)
    @flag = false
    #Since we already knew that area.geo_json is valid geo_json type
    for feature in JSON.parse(area.geo_json)['features']
      if Pip.contains?(feature.to_json, point_param.to_json)
        @flag =  true
      end
    end
    return @flag
  end

# The custom_pip? method accepts geo_json ruby hash so we may need to convert location object to that
  def geo_jsonify(location)
    return {type: 'Feature', geometry:{ type: 'Point', coordinates: [location.longitude.to_f, location.latitude.to_f]},   "properties": {
    name: location.name}}
  end
end
