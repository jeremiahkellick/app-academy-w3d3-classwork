# == Schema Information
#
# Table name: visits
#
#  id             :bigint(8)        not null, primary key
#  visitor_id     :integer
#  visited_url_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Visit < ApplicationRecord
  validates :visitor_id, :visited_url_id, presence: true
  # validates :visitor_id, uniqueness: { scope: :visited_url_id }
  
  belongs_to :visitor,
    primary_key: :id, 
    foreign_key: :visitor_id,
    class_name: :User
    
  belongs_to :visited_url,
    primary_key: :id, 
    foreign_key: :visited_url_id,
    class_name: :ShortenedUrl 
  
  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor: user, visited_url: shortened_url)
  end
end
