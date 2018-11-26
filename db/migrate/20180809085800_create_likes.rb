class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      
      
      t.belongs_to :user
      t.belongs_to :post
      #t.integer :likes_count

      t.timestamps null: false
    end
  end
end
