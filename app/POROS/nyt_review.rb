class NytReview
  attr_reader :headline, :url

  def initialize(nyt_review)
    @headline = nyt_review[:headline]
    @url = nyt_review[:link][:url]
  end
end
