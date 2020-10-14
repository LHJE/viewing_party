require "rails_helper"

RSpec.describe Movie do
  before :each do
    attrs = {
      title: "The Fountain",
      vote_average: "1",
      runtime: "5555",
      genres: [{name: "Intense"}, {name: "psychedelic"}],
      overview: "Mind blowing"
    }
    cast = [
      {character: "Guy", actor: "Hugh Jackman"}, {character: "Girl", actor: "Kierra Knightly"}
    ]
    reviews = [
      {author: "Pendleton Ward", content: "WTF!"}
    ]
    similar_films = [
      {title: "Cloud Atlas",}
    ]
    nyt_review = {
      headline: "Good movie!", link: {url: "website.com"}
    }
    @movie = Movie.new(attrs, cast, reviews, similar_films, nyt_review)
  end
  it "exists" do
    expect(@movie).to be_a Movie
    expect(@movie.title).to eq("The Fountain")
    expect(@movie.vote_average).to eq("1")
    expect(@movie.runtime).to eq("5555")
    expect(@movie.genres).to eq(["Intense", "psychedelic"])
    expect(@movie.overview).to eq("Mind blowing")
    expect(@movie.cast).to eq([
      {character: "Guy", actor: "Hugh Jackman"}, {character: "Girl", actor: "Kierra Knightly"}
    ])
    expect(@movie.reviews).to eq([
      {author: "Pendleton Ward", content: "WTF!"}
    ])
    expect(@movie.similar_films).to eq([
      {title: "Cloud Atlas",}
    ])
    expect(@movie.nyt_headline).to eq("Good movie!")
    expect(@movie.nyt_url).to eq("website.com")
  end

  it ".translate_runtime" do
    expect(@movie.translate_runtime).to eq("92hrs, 34 minutes")
  end

  it ".get_nyt_review" do
    nyt_review1 = {
      headline: "Good movie!", link: {url: "website.com"}
    }
    nyt_review2 = nil

    expect(@movie.get_nyt_review(nyt_review1)).to eq({:headline=>"Good movie!", :url=>"website.com"})
    expect(@movie.get_nyt_review(nyt_review2)).to eq({:headline=>nil, :url=>"unavailable"})
  end
end
