# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true, uniqueness: true
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
  has_many :visits, 
    primary_key: :id,
    foreign_key: :visited_url_id,
    class_name: :Visit 
    
  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  
  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging
  
  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic
  
  def self.random_code(user, long_url)
    code = SecureRandom::urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64(16)
    end
    ShortenedUrl.new(submitter: user, long_url: long_url, short_url: code)
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    # visits.select(:visitor_id).distinct.count
    visitors.count
  end
  
  def num_recent_uniques
    visits.select(:visitor_id).distinct.where(created_at: 10.minutes.ago..Time.now).count
  end
end
