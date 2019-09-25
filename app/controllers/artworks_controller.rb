class ArtworksController < ApplicationController

  def index
    if Artwork.count == 0
      render plain: "There are no artworks!"
    else
      render json: Artwork.artworks_for_user_id(params[:user_id])
    end
  end

  def create
    @artwork = Artwork.new(user_params)

    if @artwork.save
      render json: @artwork, status: :created
    else 
      render json: @artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    found = Artwork.find(params[:id])
    
    if found
      render json: found
    else
      render json: found.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @artwork = Artwork.find(params[:id])

    if @artwork.update(user_params)
      render json: @artwork
    else
      render json: @artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    render json: @artwork
  end

    private

  def user_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end

end
