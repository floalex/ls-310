class Todo < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validate_presence_of :name
  
  def name_only?
    description.blank?
  end
  
  def display_text    
    name + tag_text
  end
  
  def save_with_tags
    if save
      create_location_tags
      true
    else
      false
    end
  end
  
  private 
  
  def tag_text
    if tags.any?
      " (#{tags.one? ? 'tag' : 'tags' }: #{tags.map(&:name).first(4).join(", ")}#{', more...' if  tags.count > 4})"
    else 
      ""
    end
  end
  
  def create_location_tags
    # if the slice part is not nil, we can call .strip, otherwise not
    location_string = name.slice(/.*\bAT\b(.*)/, 1).try(:strip)
    if location_string
      locations = location_string.split(/\, |and/).map(&:strip)
      locations.each do |location|
        tags.create(name: "location:{#location_string}")
      end
    end
  end
end