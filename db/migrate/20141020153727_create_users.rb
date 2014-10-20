class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :user_type
      t.integer :school_id

      t.timestamps
    end
  end
end
