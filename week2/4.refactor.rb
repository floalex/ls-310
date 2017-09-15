# todo.rb
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
  
  def tag_text
    if tags.any?
      " (#{tags.one? ? 'tag' : 'tags' }: #{tags.map(&:name).first(4).join(", ")}#{', more...' if  tags.count > 4})"
    else 
      ""
    end
  end
end

#spec/models/todo_spec.rb
requrie 'rails_helper'

describe Todo do 
  describe "#name_only?" do
    it "returns true if the description is nil" do
      todo = Todo.new(name: "cook dinner")
      todo.name_only?.should be_true
    end
    
    it "returns true if the description is an empty string" do
      todo = Todo.new(name: "cook dinner", description: "")
      todo.name_only?.should be_true
    end
    
    it "returns false if the description is an non-empty string" do
      todo = Todo.new(name: "cook dinner", description: "Potatoes!")
      todo.name_only?.should be_false
    end
  end
  
  describe "#display_text" do
    let(:todo) { Todo.create(name: "cook dinner") }
    
    it "displays the name when there is no tags" do
      expect(todo.display_text).to eq("cook dinner")
    end
    
    it "displays the only tag with word 'tag' when there is one tag" do
       todo.tags.create(name: "home")
       expect(todo.display_text).to eq("cook dinner (tag: home)")
    end
    
    it "displays the name with multiple tags" do
      todo.tags.create(name: "home")
      todo.tags.create(name: "urgent")
      expect(todo.display_text).to eq("cook dinner (tags: home, urgent)")
    end
    
    it "displays up to four tags" do
      todo.tags.create(name: "home")
      todo.tags.create(name: "urgent")
      todo.tags.create(name: "help")
      todo.tags.create(name: "book")
      todo.tags.create(name: "prepay")
      expect(todo.display_text).to eq("cook dinner (tags: home, urgent, help, book, more...)")
    end
  end
end