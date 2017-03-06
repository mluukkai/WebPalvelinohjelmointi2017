class FixStyles < ActiveRecord::Migration
  def up
    stylenames = Beer.all.map do|beer|
      beer[:style]
    end
    
    stylenames.uniq.each do |name|
      Style.create name: name
    end

    Beer.all.each do |beer|
      style = Style.find_by name: beer[:style]
      beer.style_id = style.id
      beer.save
    end

    remove_column :beers, :style
  end    

end
