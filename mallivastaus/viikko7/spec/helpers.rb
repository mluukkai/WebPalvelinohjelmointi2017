module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_beer_with_rating(brewery, style, user, score)
    beer = FactoryGirl.create(:beer, brewery: brewery, style: style)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(brewery, style, user, *scores)
    scores.each do |score|
      create_beer_with_rating(brewery, style, user, score)
    end
  end
end