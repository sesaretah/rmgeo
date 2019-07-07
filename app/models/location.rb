class Location < ApplicationRecord
  validates_presence_of :name

  after_create :extract_geo
  def extract_geo
    HardWorker.perform_async(self.id)
  end
end
