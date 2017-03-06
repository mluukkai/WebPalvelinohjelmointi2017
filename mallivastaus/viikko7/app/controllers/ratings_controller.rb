class RatingsController < ApplicationController
  def index
    if Rails.cache.read('top_breweries').nil?
      UpdateRatingsJob.new.perform(false)
    end 
    @top_breweries = Rails.cache.read('top_breweries')
    @top_beers = Rails.cache.read('top_beers')
    @top_styles =Rails.cache.read('top_styles')
    @ratings = Rails.cache.read('ratings') 
    @users = Rails.cache.read('users')
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    if current_user.nil?
      redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating  ## virheen aiheuttanut rivi
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end
  
  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end  
end