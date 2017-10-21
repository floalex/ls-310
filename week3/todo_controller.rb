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
    if @todo.save_with_tags # move the logic to model level
      redirect_to root_path
    else
      render :new
    end
  end
end
