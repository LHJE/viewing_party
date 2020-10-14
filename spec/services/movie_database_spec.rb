require 'rails_helper'

describe MovieDatabase do
  context "instance methods" do
    context "#movie_by_id" do
      it "returns movie data", :vcr do
        movie_details = MovieDatabase.movie_details("19265")
        expect(movie_details).to be_a(Hash)

        expect(movie_details).to have_key :title
        expect(movie_details[:title]).to be_a(String)

        expect(movie_details).to have_key :vote_average
        expect(movie_details[:vote_average]).to be_a(Float)

        expect(movie_details).to have_key :runtime
        expect(movie_details[:runtime]).to be_a(Integer)

        expect(movie_details).to have_key :genres
        expect(movie_details[:genres]).to be_an(Array)
      end

      it "returns cast data", :vcr do
        cast_details = MovieDatabase.movie_actors("19265")

        expect(cast_details).to be_an(Array)

        expect(cast_details[0]).to be_a(Hash)

        expect(cast_details[0]).to have_key :character
        expect(cast_details[0][:character]).to be_a(String)

        expect(cast_details[0]).to have_key :name
        expect(cast_details[0][:name]).to be_a(String)
      end

      it "returns review data", :vcr do
        review_details = MovieDatabase.movie_reviews("19265")

        expect(review_details).to be_an(Array)

        expect(review_details[0]).to be_a(Hash)

        expect(review_details[0]).to have_key :author
        expect(review_details[0][:author]).to be_a(String)

        expect(review_details[0]).to have_key :content
        expect(review_details[0][:content]).to be_a(String)
      end

      it "returns nyt review data", :vcr do
        nyt_review_details = MovieDatabase.nyt_movie_review("Whatever Works")

        expect(nyt_review_details).to be_an(Array)

        expect(nyt_review_details[0]).to be_a(Hash)

        expect(nyt_review_details[0]).to have_key :headline
        expect(nyt_review_details[0][:headline]).to be_a(String)

        expect(nyt_review_details[0]).to have_key :link
        expect(nyt_review_details[0][:link]).to be_a(Hash)
        expect(nyt_review_details[0][:link][:url]).to be_a(String)
      end
    end
  end
end
