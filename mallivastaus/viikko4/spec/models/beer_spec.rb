require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with proper name name and style set" do
    beer = Beer.create name: "Urbock", style: "Rauch"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without name" do
    beer = Beer.create style: "Rauch"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    beer = Beer.create name: "Urbock"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end      
end