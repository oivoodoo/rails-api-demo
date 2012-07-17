class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates :title, :presence => true
  validates :content, :presence => true

  def published?
    return false if published_on.nil?

    published_on <= DateTime.now
  end
end

