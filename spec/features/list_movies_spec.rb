it "does not show a movie that hasn't yet been released" do
  movie = Movie.create(movie_attributes(released_on: 1.month.from_now))

  visit movies_path

  expect(page).not_to have_text(movie.title)
end