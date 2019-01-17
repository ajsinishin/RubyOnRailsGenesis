class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
  def movie_params
    movie_params = params.require(:movie).permit(:title, :description, :rating, :released_on, :total_grossm, :cast, :director, :duration, :inmage)
  end
  def show
    @movie = Movie.find(params[:id])
	end

  def new
    @movie = Movie.new
  end

  def update
    movie_params = params.require(:movie).permit(:title, :description, :rating, :released_on, :total_grossm, :cast, :director, :duration, :inmage)
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end
  def edit
    @movie = Movie.find(params[:id])
  end
  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag('placeholder.png')
    else
      image_tag(movie.image_file_name)
    end
  end

  def create
    @movie = Movie.new(movie_params)
    movie_params = params.require(:movie).permit(:title, :description, :rating, :released_on, :total_grossm,:cast, :director, :duration, :inmage)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end
	def destroy
	  @movie = Movie.find(params[:id])
	  @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end
  def vali
    validates :title, :released_on, :duration, presence: true
    validates :description, length: { minimum: 25 }
    validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
    validates :inmage, allow_blank: true, format: {
  with:    /\w+\.(gif|jpg|png)\z/i,
  message: "must reference a GIF, JPG, or PNG image"
  }
  end


  

end
