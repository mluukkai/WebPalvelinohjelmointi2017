require 'rails_helper'

RSpec.describe "Styles", type: :request do
  describe "GET /styles" do
    it "works! (now write some real specs)" do
      get styles_path
      expect(response).to have_http_status(200)
    end
  end
end
