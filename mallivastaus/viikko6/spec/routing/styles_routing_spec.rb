require "rails_helper"

RSpec.describe StylesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/styles").to route_to("styles#index")
    end

    it "routes to #new" do
      expect(:get => "/styles/new").to route_to("styles#new")
    end

    it "routes to #show" do
      expect(:get => "/styles/1").to route_to("styles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/styles/1/edit").to route_to("styles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/styles").to route_to("styles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/styles/1").to route_to("styles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/styles/1").to route_to("styles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/styles/1").to route_to("styles#destroy", :id => "1")
    end

  end
end
