class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :tag_topics_id
      t.integer :shortened_url_id 
      t.timestamps
    end
    
    add_index :taggings, [:tag_topics_id, :shortened_url_id], unique: true 
    add_index :taggings, :shortened_url_id
    
  end
end
