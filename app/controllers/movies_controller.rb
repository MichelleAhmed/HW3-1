# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.all_ratings
    @sorted = params[:sort_param]
    if @sorted
      session[:sort_param] = @sorted
      if (@sorted == "title")
        @title_header = "hilite"
      elsif (@sorted == "release_date")
        @release_date_header = "hilite"
      end
    elsif session[:sort_param] && @sorted
      flash.keep
      redirect_to params.merge(:sort_param => session[:sort_param])
    end
    @rated = params[:ratings]
    if @rated
      @r_hash = @rated
      @r_array = @rated.keys
      session[:ratings] = @r_hash
    elsif session[:ratings]
      flash.keep
      redirect_to params.merge(:ratings => session[:ratings])
    else
      @r_hash = {}
      @r_array = @all_ratings
    end
      @movies = Movie.find_all_by_rating(@r_array, :order => session[:sort_param])
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
