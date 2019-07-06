module Geometry
  extend ActiveSupport::Concern
  include Response
  def check_overlap(area, point_param)
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
end
