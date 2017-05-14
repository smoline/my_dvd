class DvdsController < ApplicationController
  before_action :authenticate_user!

  require 'httparty'
  require 'json'

  # GET /dvds
  def index
    @dvds = Dvd.all
  end

  # GET /dvds/1
  def show
    @dvd = Dvd.find(params[:id])
  end

  # GET /dvds/new
  def new
    @dvd = Dvd.new
    @dvd.upc = params[:upc]
    @dvd.title = params[:title]
    # @dvd.description = params[:description]
  end

  # GET /dvds/1/edit
  def edit
    @dvd = Dvd.find(params[:id])
  end

  # POST /dvds
  def create
    @dvd = Dvd.new(dvd_params)

    if @dvd.save
      redirect_to @dvd, notice: 'Dvd was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dvds/1
  def update
    @dvd = Dvd.find(params[:id])
    if @dvd.update(dvd_params)
      redirect_to @dvd, notice: 'Dvd was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dvds/1
  def destroy
    @dvd = Dvd.find(params[:id])
    @dvd.destroy
    redirect_to dvds_url, notice: 'Dvd was successfully destroyed.'
  end

  def get_barcode
    upc = params[:upc]
    @dvd = Dvd.find_or_initialize_by(upc: params[:upc])
    if @dvd.new_record?
      title = find_movie_title(upc)
      # description = find_movie_description(title)
      redirect_to new_dvd_path(upc: params[:upc], title: title)
    else
      redirect_to @dvd
    end
  end

  def find_movie_title(upc)
    response = HTTParty.get("http://www.searchupc.com/handlers/upcsearch.ashx?request_type=3&access_token=38EB43B6-3A6F-4840-9A10-150E79A0983A&upc=#{upc}")
    title = JSON.parse(response.body)["0"]["productname"]
    p title
    return title
  end

  # def find_movie_description(title)
  #   response = HTTParty.get("https://api.themoviedb.org/3/search/movie?api_key=c5bc1a29e4fbf6a35bf9ba5f8f7b4646&language=en-US&query=#{title}&page=1&include_adult=false")
  #   description = JSON.parse(response.body)["results"]["overview"]
  #   p description
    # return description
  # end

  private

  # Only allow a trusted parameter "white list" through.
  def dvd_params
    params.require(:dvd).permit(:title, :disc_type, :upc)
  end
end
