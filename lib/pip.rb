module Pip
  extend self
  #This is bascially an implementaion of the well-known point-in-polygon(pip) problem.
  #For more information please refer to: https://en.wikipedia.org/wiki/Point_in_polygon
  #Our implementaion is based on ray casting algorithm and is inspired by https://gist.github.com/kidbrax/1236253

  def contains?(polygon, point)
    extract_points(polygon, point)
    @flag = false
    @polygon_points.each_cons(2) do |segment_intial, segment_final|
      if collision?(@point, segment_intial, segment_final)
        @flag = !@flag
      end
    end
    return @flag
  end

  private

  #This is based on the idea presented here:
  # https://math.stackexchange.com/questions/1247421
  def collision?(point, intial, final)
    result = false
    case
    when vertical_right_bounded?(intial,point,final) && (slope(point, intial) < slope(final, intial))
      result = true
    when vertical_right_bounded?(final,point,intial) && (slope(point, intial) > slope(final, intial))
      result = true
    end
    return result
  end

  def vertical_right_bounded?(x,y,z)
    x[:latitude] <= y[:latitude] && y[:latitude] < z[:latitude] ?  true : false
  end

  def slope(a,b)
    return (a[:longitude]-b[:longitude])/(a[:latitude] - b[:latitude])
  end

  def extract_points(polygon, point)
    parsed_point = JSON.parse(point)
    polygon = JSON.parse(polygon)
    @point = {latitude: parsed_point['geometry']['coordinates'][0], longitude: parsed_point['geometry']['coordinates'][1]}
    @polygon_points = []
    for item in polygon['geometry']['coordinates'][0]
      @polygon_points << {latitude: item[0].to_f, longitude: item[1].to_f}
    end
  end
end
