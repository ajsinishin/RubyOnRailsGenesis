class Movie < ApplicationRecord
	has_many :reviews, dependent: :destroy

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def Imnage 
  		string :inmage
  end

  def self.released
    where("released_on <= ?", Time.now).order("released_on desc")
  end

	def average_stars
	  reviews.average(:stars)
	end

	def format_average_stars(movie)
	  if movie.average_stars.nil?
	    content_tag(:strong, 'No reviews')
		else
	    pluralize(number_with_precision(movie.average_stars, precision: 1) , 'star')
		end
	end
end
