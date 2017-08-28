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
end


class Todo < ActiveRecord::Base
  has_many :tags
  
  def name_only?
    # description.nil? || description == ""
    description.blank?
  end
end