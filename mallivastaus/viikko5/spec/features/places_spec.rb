require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    allow(WeatherService).to receive(:weather_for).with("kumpula").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several is returned by the API, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("malmi").and_return(
      [ 
        Place.new( name:"Eke's pub", id: 1 ),
        Place.new( name:"Konja", id: 2 ),
        Place.new( name:"Beerhaus Malmi", id: 3 )   
      ]
    )

    allow(WeatherService).to receive(:weather_for).with("malmi").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'malmi')
    click_button "Search"

    expect(page).to have_content "Eke's pub"
    expect(page).to have_content "Konja"
    expect(page).to have_content "Beerhaus Malmi"
  end  

  it "if none is returned by the API, notification of that us shown the page" do
    allow(BeermappingApi).to receive(:places_in).with("nuorgam").and_return(
      [ ]
    )

    allow(WeatherService).to receive(:weather_for).with("nuorgam").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'nuorgam')
    click_button "Search"
    expect(page).to have_content "No locations known"
  end  
end