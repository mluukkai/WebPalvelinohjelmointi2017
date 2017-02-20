class PlacesController < ApplicationController
  def index
  end

  def show
    @place = BeermappingApi.place_in(session['last_city'], params[:id])
  end
  
  def search
    @places = BeermappingApi.places_in(params[:city])
    session['last_city'] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end
