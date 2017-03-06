require 'rails_helper'

RSpec.describe "styles/new", type: :view do
  before(:each) do
    assign(:style, Style.new(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new style form" do
    render

    assert_select "form[action=?][method=?]", styles_path, "post" do

      assert_select "input#style_name[name=?]", "style[name]"

      assert_select "textarea#style_description[name=?]", "style[description]"
    end
  end
end
