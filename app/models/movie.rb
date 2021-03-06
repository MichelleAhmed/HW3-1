class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def Movie.all_ratings
    Movie.all.map{|movie| movie.rating}.uniq
  end
end
