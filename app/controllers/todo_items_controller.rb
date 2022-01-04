class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]
 
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  def complete
    if @todo_item.completed_at.blank?
      @todo_item.update_attribute(:completed_at, Time.now)
    else
      @todo_item.update_attribute(:completed_at, "")
    end
    redirect_to @todo_list, notice: "Todo item completed"
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
     flash[:success] = "Item deleted successfully."
    else
     flash[:error] = "Something went wrong"
    end
    redirect_to @todo_list 
   end

 private
 
 def set_todo_list
  @todo_list = TodoList.find(params[:todo_list_id])
 end

 def set_todo_item
  @todo_item = @todo_list.todo_items.find(params[:id])
 end
 
 def todo_item_params
  params[:todo_item].permit(:content)
 end

end