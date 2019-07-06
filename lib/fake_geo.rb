module FakeGeo
  extend self
  def feature_collection
    #Every feature collection has set of featues for simplicity here we include few features
    return {type: 'FeatureCollection', "features": FakeGeo.feature(rand(1..3))}
  end

  def feature(no = 1)
    features = []
    for i in 0..no
      #Every feutre has set of properties and at least 3 points that a bounding polygons of that ...
      # ... points forms the polygon
      features << {type: "Feature", properties: {}, geometry:{ "type": "Polygon", "coordinates": [FakeGeo.latlon(rand(3..6))]}}
    end
    return features
  end

  def latlon(no = 3)
    latlons = []
    for i in 1..no
      #Here we use Faker gem to get random points i.e., points with longitude and latitude tuple
      latlons << [Faker::Address.latitude, Faker::Address.longitude]
    end
    #first and last position must be the same
    latlons << latlons[0]
    return latlons
  end
end
