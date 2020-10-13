class AddMovieDbIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :movie_db_id, :integer
  end
end
