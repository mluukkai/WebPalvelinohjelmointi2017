class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_admin_signed_in, only: :destroy  
  before_action :skip_if_cached, only:[:index]

  # GET /breweries
  # GET /breweries.json
  def index
    order = params[:order] || 'name'
    
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired

    @breweries = @active_breweries+@retired_breweries

    @active_breweries = @active_breweries.sort_by{ |b| b.send(order) }
    @retired_breweries = @retired_breweries.sort_by{ |b| b.send(order) } 

    session[:reverse] ||= false

    if order == session[:previous_order] 
      if not session[:reverse] 
        @active_breweries = @active_breweries.reverse
        @retired_breweries = @retired_breweries.reverse
      end

      session[:reverse] = !session[:reverse]
    end

    session[:previous_order] = order
  end

  def list
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    expire_fragments
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else    
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    expire_fragments
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    expire_fragments
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    expire_fragments
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end

    def skip_if_cached
      @order = params[:order] || 'name'
      return render :index if fragment_exist?( "brewerylist-#{@order}"  )
    end 

    def expire_fragments
      ["brewerylist-name", "brewerylist-brewery", "brewerylist-style"].each{ |f| expire_fragment(f) }
    end
end