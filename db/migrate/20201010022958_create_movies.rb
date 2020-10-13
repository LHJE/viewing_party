class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.float :vote_average
      t.string :genre, array: true, default: []
      t.string :summary
      t.integer :total_reviews

      t.timestamps
    end
  end
end
