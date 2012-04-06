class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    @tags  = Group.tags
  end

  def create
    @group = Group.new(params[:group])

    #Chose-jQuery plugin sends an addtional blank first item
    @group.tags.delete_at(0)

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

  # Submit new group
  def submit
    # Send email to administrator with params[:group]

    redirect_to :back, notice: "The group will be moderated, and hopefully it will be added to site soon."
  end
end
