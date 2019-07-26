# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string
#  short_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :long_url, :user_id, presence: true

  def self.random_code
    code = SecureRandom.urlsafe_base64(16)
    if self.exists?({:short_url => code})
      self.random_code
    else
      code
    end
  end

  def self.shorten_url(user, long_url)
    self.create!({:long_url => long_url, :short_url => self.random_code, :user_id => user.id})
  end

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id, 
    class_name: :User

  has_many :visitors,
    Proc.new { distinct }, 
    through: :visits,
    source: :visitor

  has_many :visits,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :Visit

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visits.select(:user_id).count
  end

  def num_recent_uniques
    self.visits.select(:user_id).where({ created_at: (Time.now - 30.minutes)..Time.now }).count
  end

end

