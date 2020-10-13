class RemoveVoteAverageFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :genre, :string
    remove_column :movies, :summary, :string
    remove_column :movies, :total_reviews, :string
  end
end
