# == Schema Information
#
# Table name: taggings
#
#  id               :bigint(8)        not null, primary key
#  tag_topics_id    :integer
#  shortened_url_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Tagging < ApplicationRecord
  validates :tag_topics_id, :shortened_url_id, presence: true
  validates :tag_topics_id, uniqueness: { scope: :shortened_url_id }
  
  belongs_to :tag_topic,
    primary_key: :id,
    foreign_key: :tag_topics_id,
    class_name: :TagTopic
  
  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :ShortenedUrl
end
