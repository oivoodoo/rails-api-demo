class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates :title, :presence => true
  validates :content, :presence => true

  scope :published, lambda {
    where("published_on IS NOT NULL").
    where("published_on <= ?", DateTime.now).
    order("published_on DESC")
  }

  scope :unpublished, lambda {
    where("published_on IS NULL or published_on > ?", DateTime.now).
    order("published_on DESC")
  }

  def total_words
    words(title) + words(content)
  end

  private

  def words(text)
    text.scan(/\w+/).count
  end
end

