class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :genres,
              :overview,
              :cast,
              :reviews,
              :similar_films,
              :nyt_headline,
              :nyt_url

  def initialize(attrs, cast, reviews, similar_films, nyt_review)
    @title = attrs[:title]
    @vote_average = attrs[:vote_average]
    @runtime = attrs[:runtime]
    @genres = get_genres(attrs[:genres])
    @overview = attrs[:overview]
    @cast = cast
    @reviews = reviews
    @similar_films = similar_films
    @nyt_headline = get_nyt_review(nyt_review)[:headline]
    @nyt_url = get_nyt_review(nyt_review)[:url]
  end

  def translate_runtime
    hours = @runtime.to_i / 60
    minutes = ((@runtime.to_f / 60 - @runtime.to_i / 60) * 60).to_i
    @runtime = "#{hours}hrs, #{minutes} minutes"
  end

  def get_genres(genre_hashes)
    genre_hashes.map do |hash|
      hash[:name]
    end
  end

  def get_nyt_review(nyt_review)
    if nyt_review.nil?
      { headline: nil, url: 'unavailable' }
    else
      { headline: nyt_review[:headline], url: nyt_review[:link][:url] }
    end
  end
end
