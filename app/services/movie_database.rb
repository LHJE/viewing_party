class MovieDatabase
  def self.movie_details(movie_id)
    key = ENV['MOVIEDB_API_KEY']
    url = 'https://api.themoviedb.org'
    uri = "/3/movie/#{movie_id}?api_key=#{ENV['MOVIEDB_API_KEY']}&language=en-US"
    get_results(url, key, uri)
  end

  def self.movie_actors(movie_id)
    key = ENV['MOVIEDB_API_KEY']
    url = 'https://api.themoviedb.org'
    uri = "/3/movie/#{movie_id}/credits?api_key=#{ENV['MOVIEDB_API_KEY']}"
    get_results(url, key, uri)[:cast].take(10)
  end

  def self.movie_reviews(movie_id)
    key = ENV['MOVIEDB_API_KEY']
    url = 'https://api.themoviedb.org'
    uri = "/3/movie/#{movie_id}/reviews?api_key=#{ENV['MOVIEDB_API_KEY']}&language=en-US&page=1"
    get_results(url, key, uri)[:results]
  end

  def self.nyt_movie_review(movie_title)
    title = movie_title.parameterize(separator: '_')
    key = ENV['NYT_MOVIE_REVIEWS_API_KEY']
    url = 'https://api.nytimes.com'
    uri = "/svc/movies/v2/reviews/search.json?api-key=#{ENV['NYT_MOVIE_REVIEWS_API_KEY']}&query=#{title}"
    response = get_results(url, key, uri)[:results]
    response.map do |review_data|
      NytReview.new(review_data)
    end
  end

  def self.movie_similar(movie_id)
    key = ENV['MOVIEDB_API_KEY']
    url = 'https://api.themoviedb.org'
    uri = "/3/movie/#{movie_id}/similar?api_key=#{ENV['MOVIEDB_API_KEY']}&language=en-US&page=1"
    get_results(url, key, uri)[:results]
  end

  def self.get_results(url, key, uri)
    conn = Faraday.new(url: url) do |faraday|
      faraday.headers['X-API-Key'] = key
    end
    results = conn.get(uri)
    JSON.parse(results.body, symbolize_names: true)
  end
end
