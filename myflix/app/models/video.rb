class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(search_term)
    return [] if search_term.blank?
    # use of %: WHERE CustomerName LIKE '%or%':	Finds any values that have "or" in any position
    where("LOWER(title) LIKE ?", "%#{search_term.downcase}%").order("created_at DESC")
  end
end