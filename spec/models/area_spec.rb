require 'rails_helper'

RSpec.describe Area, type: :model do
  it { should validate_presence_of(:geo_json) }
end
