class Admins::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genre_blog = Genre.where(genre_status: true)
    @genre_item = Genre.where(genre_status: false)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :genre_status)
  end
end
