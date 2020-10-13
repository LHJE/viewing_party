class CreatePartyUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :party_users do |t|
      t.references :party, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
