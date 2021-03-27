class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genre = Genre.new
    @genre_blog = Genre.where(genre_status: true)
    @genre_item = Genre.where(genre_status: false)
  end

  def create
    @genre = Genre.new(genre_params)
    @genre_blog = Genre.where(genre_status: true)
    @genre_item = Genre.where(genre_status: false)
    if @genre.save
      redirect_to admins_genres_path
    else
      flash[:notice] = "必要な項目が未入力です"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path
    else
      flash[:notice] = "必要な項目が未入力です"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :genre_status)
  end
end
