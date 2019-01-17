it "is released when the released on date is in the past" do
  movie = Movie.create(movie_attributes(released_on: 3.months.ago))

  expect(Movie.released).to include(movie)
end

it "is not released when the released on date is in the future" do
  movie = Movie.create(movie_attributes(released_on: 3.months.from_now))

  expect(Movie.released).not_to include(movie)
end

it "returns released movies ordered with the most recently-released movie first" do
  movie1 = Movie.create(movie_attributes(released_on: 3.months.ago))
  movie2 = Movie.create(movie_attributes(released_on: 2.months.ago))
  movie3 = Movie.create(movie_attributes(released_on: 1.months.ago))

  expect(Movie.released).to eq([movie3, movie2, movie1])
end
it "has many reviews" do
  movie = Movie.new(movie_attributes)

  review1 = movie.reviews.new(review_attributes)
  review2 = movie.reviews.new(review_attributes)

  expect(movie.reviews).to include(review1)
  expect(movie.reviews).to include(review2)
end

it "deletes associated reviews" do
  movie = Movie.create(movie_attributes)

  movie.reviews.create(review_attributes)

  expect {
    movie.destroy
  }.to change(Review, :count).by(-1)
end
it "calculates the average number of review stars" do
  movie = Movie.create(movie_attributes)

  movie.reviews.create(review_attributes(stars: 1))
  movie.reviews.create(review_attributes(stars: 3))
  movie.reviews.create(review_attributes(stars: 5))
  
  expect(movie.average_stars).to eq(3)
end
