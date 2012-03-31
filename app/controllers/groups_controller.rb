class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to groups_path, notice: "Group has been added successfully."
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path, notice: "Group has been deleted successfully."
  end
end
