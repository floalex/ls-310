class Video < ActiveRecord::Base
  ## Elasticsearch proxy: __elasticsearch__
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  index_name "myflix_#{Rails.env}"
  
  belongs_to :category
  has_many :reviews, -> { order(created_at: :desc) }
  
  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader
  
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(search_term)
    return [] if search_term.blank?
    # use of %: WHERE CustomerName LIKE '%or%':	Finds any values that have "or" in any position
    where("LOWER(title) LIKE ?", "%#{search_term.downcase}%").order("created_at DESC")
  end
  
  def rating
    avg = reviews.average(:rating)
    avg.round(1) if avg
  end
  
  def self.search(query, options={})
    search_definition = {
      query: {
        multi_match: {
          query: query,
          # matches with video titles will have the most weight, then the matches against video 
          # descriptions, and finally matches against videos' reviews. Specifically, the weights 
          # for the three are going to be 100:50:1.
          fields: ['title^100', 'description^50'],
          operator: 'and'
        }
      }
    }
    
    if query.present? && options[:reviews].present?
      search_definition[:query][:multi_match][:fields] << "reviews.content"
    end
    
    __elasticsearch__.search(search_definition)
  end
  
  def as_indexed_json(options={})
    as_json(
      only: [:title, :description],
      include: {
        reviews: { only: [:content] }
      }
    )
  end
end