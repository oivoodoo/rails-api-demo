class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates :title, :presence => true
  validates :content, :presence => true

  scope :published, lambda {
    where("published_on IS NOT NULL").
    where("published_on <= ?", DateTime.now).
    order("published_on DESC")
  }
end

