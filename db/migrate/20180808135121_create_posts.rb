class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      #t.string :image, :default => "" #, default: ""
      t.string :video
      t.integer :user_id, foreign_key: true
      t.integer :category
      t.integer :likes_count
      t.text :body
     
      t.timestamps null: false
    end
  end
end
