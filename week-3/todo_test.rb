# todos_controller.rb
class TodosController < ApplicationController
  def index 
    @todos = Todo.all
  end
  
  def new
    @todo = Todo.new
  end
  
  def create
    @todo = Todo.new(params[:todo])
    if @todo.save
      # if the slice part is not nil, we can call .strip, otherwise not
      location_string = @todo.name.slice(/.*\bAT\b(.*)/, 1).try(:strip)
      if location_string
        locations = location_string.split(/\, |and/).map(&:strip)
        locations.each do |location|
          @todo.tags.create(name: "location:{#location_string}")
        end
      end
      redirect_to root_path
    else
      render :new
    end
  end
end

# spec/controllers/todos_controller_spec.rb
require 'spec_helper'

describe TodosController do
  describe "GET index" do
    it "sets the @todos variable" do
      cook = Todo.create(name: "cook")
      sleep = Todo.create(name: "sleep")
      
      get :index
      assigns(:todos).should == [cook, sleep]
    end
    
    it "renders the index template" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "GET new" do
    it "sets the @todo variable" do
      get :new
      assigns(:todo).should be_new_record
      assigns(:todo).should be_instance_of(Todo)
    end
    
    it " renders the new template" do
      get :new
      response.should render_template :new
    end
  end
  
  describe "Post create" do
    it "creates the todo record when the input is valid" do
      # always start with the action
      post :create, todo: {name: "cook", description: "I like cooking"}
      expect(Todo.first.name).to be == "cook"
      expect(Todo.first.description).to be == "I like cooking"
    end
    
    it "redirect to the root path if the input is valid" do
      post :create, todo: {name: "cook", description: "I like cooking"}
      expect(response).to redirect_to(root_path)
    end
    
    it "does not create todo when the input is invalid" do
      post :create, todo: {name: "cook", description: "I like cooking"}
      expect(Todo.count).to eq(0)
    end
    
    it "renders the new template when the input is invalid" do
      post :create, todo: {name: "cook", description: "I like cooking"}
      response.should render_template :new
    end
    
    it "does not create tags without inline locations" do
      post :create, todo: {name: "cook"}
      Tag.count.should == 0
    end
    
    it "does not create tags with at in a word without inline locations" do
      post :create, todo: {name: "eat an apple"}
      Tag.count.should == 0
    end
    
    it "creates a tag with upcase AT" do
      post :create, todo: { name: "shop AT the Apple store" }
      Tag.all.map(&:name).should == ["location:the Apple store"]
    end
    
    context "with inline locations" do
      it "creates a tag with one location" do
        post :create, todo: {name: "cook AT home"}
        Tag.all.map(&:map).should == ['location:home']
      end
      
      it "creates two tags with two locations" do
        post :create, todo: {name: "cook AT home and work"}
        Tag.all.map(&:map).should == ['location:home', 'location:work']
      end
      
      it "creates multiple tags with four locations" do
        post :create, todo: {name: "cook AT home, work, school and library"}
        Tag.all.map(&:map).should == ['location:home', 'location:work', 'location:school', 'location:library']
      end
      
    end
  end
end