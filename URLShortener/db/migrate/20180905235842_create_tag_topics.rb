class CreateTagTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_topics do |t|
      t.string :name 
      t.timestamps
    end
    
    add_index :tag_topics, :name, unique: true 
  end
end
