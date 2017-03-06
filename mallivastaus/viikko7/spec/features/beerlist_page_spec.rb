require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order by default", js: true do
    visit beerlist_path
    expect_beers_in_order("Fastenbier", "Lechte Weisse", "Nikolai")
  end  

  it "shows beers in ordered by style when asked", js: true do
    visit beerlist_path
    click_link('Style')
    expect_beers_in_order("Nikolai", "Fastenbier", "Lechte Weisse")
  end  

  it "shows beers in ordered by style when asked", js: true do
    visit beerlist_path
    click_link('Brewery')
    expect_beers_in_order("Lechte Weisse", "Nikolai", "Fastenbier", )
  end  

  def expect_beers_in_order(first, second, third)
    first_row = find('table').find('tr:nth-child(2)')
    second_row = find('table').find('tr:nth-child(3)')
    third_row = find('table').find('tr:nth-child(4)')
    expect(first_row).to have_content first
    expect(second_row).to have_content second
    expect(third_row).to have_content third
  end
end