require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when several exist" do
    before :each do
      create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user, 10, 7, 9)
      visit ratings_path
    end

    it "all are shown at ratings page" do
      expect(page).to have_content "anonymous 10 #{user.username}"
      expect(page).to have_content "anonymous 7 #{user.username}"
      expect(page).to have_content "anonymous 9 #{user.username}"
    end

    it "their count is shown ratings page" do
      expect(page).to have_content "Total of #{Rating.count} ratings given"
    end
  end
end