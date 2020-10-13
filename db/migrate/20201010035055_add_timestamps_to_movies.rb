class AddTimestampsToMovies < ActiveRecord::Migration[5.2]
    def change_table
      add_column :movies, :created_at, :datetime, null: false
      add_column :movies, :updated_at, :datetime, null: false
    end
end
