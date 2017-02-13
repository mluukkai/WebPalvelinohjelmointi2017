require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end    
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "when have givent ratings" do
    before :each do
      create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user, 7, 9)
      create_beers_with_ratings(FactoryGirl.create(:brewery, name: "Schlenkerla"), "bock", user, 10)
      user2 = FactoryGirl.create(:user, username: "Brian")
      create_beers_with_ratings(FactoryGirl.create(:brewery), "helles", user2, 50)
      visit user_path(user.id)
    end

    it "those are listed at users page" do
      expect(page).to have_content "anonymous 10"
      expect(page).to have_content "anonymous 7"
      expect(page).to have_content "anonymous 9"
    end

    it "only those are listed users page" do
      expect(page).to have_no_content "anonymous 50"
    end 

    it "when logged in, can delete own ratings" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit user_path(user.id)
      expect{
        page.all('a')[10].click
      }.to change{Rating.count}.by(-1)
    end  

    it "favorite style is shown at user page" do
      expect(page).to have_content "Favorite style: bock"  
    end 

    it "favorite brewery is shown at user page" do
      expect(page).to have_content "Favorite brewery: Schlenkerla"  
    end     
  end
end