class AddImpressionsCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :impressions_count, :int
  end
end