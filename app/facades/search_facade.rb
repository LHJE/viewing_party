class SearchFacade
  def self.find_movie(movie_id)
    attributes = MovieDatabase.movie_details(movie_id)
    cast = MovieDatabase.movie_actors(movie_id)
    reviews = MovieDatabase.movie_reviews(movie_id)
    similar_films = MovieDatabase.movie_similar(movie_id)
    unless MovieDatabase.nyt_movie_review(attributes[:title]).nil?
      nyt_review = MovieDatabase.nyt_movie_review(attributes[:title])[0]
    end
    Movie.new(attributes, cast, reviews, similar_films, nyt_review)
  end
end
