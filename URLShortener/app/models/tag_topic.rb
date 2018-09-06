# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: :Tagging
  
  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url
  
  def popular_links
    shortened_urls.order(num_clicks: :desc).limit(5).to_a
  end
end
