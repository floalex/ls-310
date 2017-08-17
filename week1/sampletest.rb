# rails g rspec:install to have rpsec file

# run `rspec` to test

# models/todo_spec.rb
require 'rails_helper'

describe Todo do
  it "saves itself" do
    todo = Todo.new(name: "cood dinner", description: "I love cooking")
    todo.save
    
    Todo.first.name.should == "cook dinner"
  end
end