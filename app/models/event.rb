# == Schema Information
#
# Table name: events
#
#  id        :integer          not null, primary key
#  starts_at :datetime
#  ends_at   :datetime
#  address   :string(255)
#

class Event < ActiveRecord::Base
  acts_as :topic
  acts_as_taggable

  has_and_belongs_to_many :people
  has_many :indications, as: :questionable

  scope :upcoming, -> { where("ends_at >= ?", Time.now.utc - 6.hours).order("ends_at") }
  scope :recent, -> { where("ends_at < ?", Time.now.utc - 6.hours).order("ends_at").reverse }
  scope :featured, -> { upcoming.limit(8) }

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :address, presence: true
end
