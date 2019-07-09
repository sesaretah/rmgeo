class HardWorker
  include Sidekiq::Worker

  def perform(location_id)
    @location = Location.find(location_id)
    a = Geokit::Geocoders::OSMGeocoder.geocode @location.name
    if a.success
      @location.longitude = a.lng.to_f
      @location.latitude =  a.lat.to_f
      @location.save
    end
  end
end
