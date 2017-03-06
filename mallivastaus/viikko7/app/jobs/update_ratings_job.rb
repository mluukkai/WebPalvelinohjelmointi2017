class UpdateRatingsJob
  include SuckerPunch::Job

  def perform(restart=true)
    sleep 1
    puts "updating stats"
    ActiveRecord::Base.connection_pool.with_connection do
      Rails.cache.write('top_breweries', Brewery.top(3).map{ |b| to_struct(b) } )
      Rails.cache.write('top_beers', Beer.top(3).map{ |b| to_struct(b) } )
      Rails.cache.write('top_styles', Style.top(3).map{ |b| to_struct(b) } )
      Rails.cache.write('ratings', Rating.recent)  
      Rails.cache.write('users', User.most_active(5))  
    end
    puts "finished updating stats"
    UpdateRatingsJob.perform_in(60.seconds) if restart
  end

  def to_struct(item)
    OpenStruct.new( url: item.id, name:item.name, average_rating:item.average_rating ) 
  end
end