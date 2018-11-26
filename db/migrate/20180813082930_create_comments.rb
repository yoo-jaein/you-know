class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :username
      t.integer :user_id, foreign_key: true
      t.belongs_to :post
      t.string :audio, :counter_cache => true

      t.timestamps null: false
    end
  end
end
