# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  url_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Visit < ApplicationRecord
  validates :user_id, :url_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!({:user_id => user.id, :url_id => shortened_url.id})
  end
  
  belongs_to :visitor,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :url,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :ShortenedUrl
    
end
