class RemoveUniqeIndexOnVisit < ActiveRecord::Migration[5.1]
  def change
    remove_index :visits, name: "index_visits_on_visitor_id_and_visited_url_id"
    add_index :visits, :visitor_id
  end
end
