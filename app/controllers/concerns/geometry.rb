module Geometry
  extend ActiveSupport::Concern
  include Response
  # First it checks if the given point and region conforms with RFC 7946, responds 422 if it fails ...
  #.. then it checks wheter any of regions contain the point or not
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

  def custom_pip?(area, point_param)
    p point_param
    @flag = false
    for feature in JSON.parse(area.geo_json)['features']
      if Pip.contains?(feature.to_json, point_param.to_json)
        @flag =  true
      end
    end
    return @flag
  end

  def geo_jsonify(location)
    return {type: 'Feature', geometry:{ type: 'Point', coordinates: [location.longitude.to_f, location.latitude.to_f]},   "properties": {
    name: location.name}}
  end
end
